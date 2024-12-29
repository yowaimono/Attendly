import http from '@ohos.net.http';

class QueryParams {
  private params: Map<string, string>;
  constructor() {
    this.params = new Map();
  }
  public add(key: string, value: string): void {
    this.params.set(key, value);
  }


  private jsonToMap(jsonStr: string): Map<string, string> {
    let objMap: Map<string, string> = new Map();

    try {
      // 1. 去除首尾的空格和花括号
      jsonStr = jsonStr.trim();
      if (jsonStr.startsWith('{') && jsonStr.endsWith('}')) {
        jsonStr = jsonStr.slice(1, -1).trim();
      } else {
        throw new Error('Invalid JSON format: must be an object');
      }

      // 2. 分割键值对
      let keyValuePairs: string[] = jsonStr.split(',');
      for (let pair of keyValuePairs) {
        pair = pair.trim();
        if (!pair) continue; // 跳过空字符串

        // 3. 分割键和值
        let parts: string[] = pair.split(':');
        if (parts.length!== 2) {
          throw new Error('Invalid key-value pair format');
        }
        let key: string = parts[0].trim();
        let value: string = parts[1].trim();


        if (!key || !value) {
          throw new Error('Invalid key-value pair format');
        }

        // 4. 去除键和值的引号
        if (key.startsWith('"') && key.endsWith('"')) {
          key = key.slice(1, -1);
        }
        if (value.startsWith('"') && value.endsWith('"')) {
          value = value.slice(1, -1);
        }

        // 5. 添加到 Map
        objMap.set(key, value);
      }
    } catch (error) {
      console.error('Error parsing JSON to Map:', error);
      throw new Error('Failed to convert JSON to Map');
    }

    return objMap;
  }

  public setParams(params: Map<string, string>): void {
    this.params = params;
  }

  // 根据Object初始化
  public static  from(obj: object): QueryParams {
    let jsonStr: string = JSON.stringify(obj);
    // 转成json字符串
    let queryParams: QueryParams = new QueryParams();
    // 解析成Map
    let objMap: Map<string, string> = queryParams.jsonToMap(jsonStr);
    queryParams.setParams(objMap);
    return queryParams;
  }


  public size(): number {
    return this.params.size;
  }


  public empty(): boolean {
    return this.params.size === 0;
  }
  public toString(): string {
    let result = '';
    if (this.params.size > 0) {
      result += '?';
      for (let item of this.params) {
        result += item[0] + '=' + item[1] + '&';
      }
    }

    return result;
  }

  public getUrl(url: string) : string {
    let result:string = url;
    result += this.toString();
    return result;
  }

  public getParams(): Map<string, string> {
    return this.params;
  }

}

class Header {
  private option: Map<string, string>;
  constructor(option: Map<string, string> = new Map()) {
    this.option = option;
  }
  public set(key: string, value: string): void {
    this.option.set(key, value);
  }

  public  size(): number {
    return this.option.size;
  }
  public get(key: string): string | undefined {
    return this.option.get(key);
  }

  public has(key: string): boolean {
    return this.option.has(key);
  }

  public delete(key: string): boolean {
    return this.option.delete(key);
  }

  public clear(): void {
    this.option.clear();
  }

  public getOption(): Map<string, string> {
    return this.option;
  }

  // 把所有key-value转成object
  public toObject(): object {
    let obj: object = new Object();
    for (let item of this.option) {
          obj[item[0]] = item[1];
    }
    return obj;
  }

  public  empty(): boolean {
    return this.option.size === 0;
  }

}

class Request {
  private BaseUrl: string;
  private TimeOut: number;
  private req: http.HttpRequest;
  private  PreHandler: Function[];
  private  PostHandler: Function[];

  constructor(BaseUrl: string, TimeOut: number) {
    this.BaseUrl = BaseUrl;
    this.TimeOut = TimeOut;
    this.req = http.createHttp();
    this.PreHandler = [];
    this.PostHandler = [];

  }

  public UseAfter(handler: Function) {
    // 检测函数类型 (header: Header) => void

    this.PostHandler.push(handler);
  }

  public UseBefore(handler: Function) {
    this.PreHandler.push(handler);
  }

  private async doPreHandler(handlers: Function[],request: Header): Promise<void> {
      for (let handler of handlers) {
          await handler(request);
      }
  }

  private  async doPostHandler(handlers: Function[], response: http.HttpResponse): Promise<void> {
      for (let handler of handlers) {
          await handler(response);
      }
  }

  public async get(url: string, params: QueryParams = new QueryParams(), header: Header = new Header()): Promise<http.HttpResponse> {
    let requestUrl = this.BaseUrl + url;

    if (!params.empty()) {
      requestUrl = params.getUrl(requestUrl);
    }

    if (!header.has('Content-Type')) {
      header.set('Content-Type', 'application/json');
    }


    // 执行前置中间件
    await this.doPreHandler(this.PreHandler, header);

    let response: http.HttpResponse;


      // 发送请求
      response = await this.req.request(requestUrl, {
        method: http.RequestMethod.GET,
        header: header.toObject(),
        connectTimeout: this.TimeOut,
        readTimeout: this.TimeOut,
      });

      // 执行后置中间件
      await this.doPostHandler(this.PostHandler, response);


    return response;


  }

  public async post(url: string, data: object, header: Header = new Header()): Promise<http.HttpResponse> {
    let requestUrl = this.BaseUrl + url;

    // if (data instanceof FormData) {
    //     header.option = new Map();
    // }
    if (!header.has('Content-Type')) {
      header.set('Content-Type', 'application/json');
    }



    // 执行用户自定义的前置处理器
    await this.doPreHandler(this.PreHandler,header);


    let response: http.HttpResponse;
    response = await this.req.request(requestUrl, {
      method: http.RequestMethod.POST,
      header: header.toObject(),
      extraData: data,
      connectTimeout: this.TimeOut,
      readTimeout: this.TimeOut,
    })


    // 执行用户自定义的后置处理器
    await this.doPostHandler(this.PostHandler, response);
    return response;

  }
}


const req: Request = new Request('http://localhost:8080/api/v1', 100000);


req.UseAfter((response: http.HttpResponse) => {
  console.log(`post handler: ${response.result}`);
})

req.UseBefore((header: Header) => {
  console.log(`pre handler: ${JSON.stringify(header.toObject())}`);
})

export default req;

export {
  QueryParams,
  Header,
}


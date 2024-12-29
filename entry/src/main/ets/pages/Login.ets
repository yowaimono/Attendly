import router from '@ohos.router';
import req from '../api/index'
import {QueryParams,Header} from '../api/index'
import http from   '@ohos.net.http';
interface LoginReq{
  username: string;
  password: string;
}


interface Result<T> {
  code: number;
  message: string;
  data: T;
}

@Entry
@Component
struct Login {
  @State username: string = '';
  @State password: string = '';

  build() {
    Column({ space: 10 }) {
      TextInput({ placeholder: '用户名' })
        .width('80%')
        .onChange((value: string) => {
          this.username = value;
        });

      TextInput({ placeholder: '密码' })
        .width('80%')
        .type(InputType.Password)
        .onChange((value: string) => {
          this.password = value;
        });

      Button('登录')
        .width('80%')
        .onClick(async () => {
          if (this.username && this.password) {
            console.log('登录成功，跳转到主页');
            // 打印用户名密码
            console.log('用户名：' + this.username);
            console.log('密码：' + this.password);

            let data:LoginReq = {
              username: this.username,
              password: this.password
            }



            // 登录请
            let query:QueryParams = QueryParams.from(data);
            console.log(query.toString());

            let header: Header = new Header();
            header.set('token', 'adasdad');

            let response: http.HttpResponse = await req.post('/u/login',data,header);

            console.log(`${response}`);
            router.pushUrl({ url: 'pages/Home' });

          } else {
            console.log('用户名或密码不能为空');
          }
        });
    }


    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center);
  }
}
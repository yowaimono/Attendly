import router from '@ohos.router';

@Entry
@Component
export default struct HomeIndex {
  build() {
    Column({ space: 20 }) {
      // 1. 顶部轮播图（暂时用 Text 代替）
      Text('这里是轮播图')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .height(150)
        .textAlign(TextAlign.Center)
        .backgroundColor('#f0f0f0');

      // 2. 中间一行四个图标（暂时用 Text 代替）
      Row({ space: 20 }) {
        Text('请假')
          .fontSize(16)
          .onClick(() => {
            console.log('图标1点击');
            router.pushUrl({
              url: '/pages/Leave'
            })
          });

        Text('图标2')
          .fontSize(16)
          .onClick(() => {
            console.log('图标2点击');
          });

        Text('图标3')
          .fontSize(16)
          .onClick(() => {
            console.log('图标3点击');
          });

        Text('图标4')
          .fontSize(16)
          .onClick(() => {
            console.log('图标4点击');
          });
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceAround)
      .padding(10);

      // 3. 底部签到区域

      Column() {
        // Text('签到区域')
        //   .fontSize(18)
        //   .margin({ bottom: 10 });

        Button('签到')
          .width(200) // 设置宽度
          .height(200) // 设置高度（与宽度相同）
          .fontSize(16)
          .backgroundColor($r('app.color.theme_color'))
          .borderRadius('50%') // 设置为宽度的一半
          .onClick(() => {
            console.log('签到按钮点击');
          });
      }
      .width('100%')
      .height('50%')
      .padding(20)
      .backgroundColor('#f9f9f9')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center);
    }
    .width('100%')
    .height('100%')
    .padding(10)
    .backgroundColor('#ffffff');
  }
}
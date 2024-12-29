@Entry
@Component
export default struct Profile {
  build() {
    Column({ space: 20 }) {
      // 1. 圆形头像
      Image($r('app.media.foreground')) // 假设本地图片资源为 avatar.png
        .width(100)
        .height(100)
        .borderRadius(50) // 设置为圆形
        .border({ width: 2, color: '#cccccc' }) // 添加边框
        .margin({ top: 20 });

      // 2. 用户名
      Text('张三')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 10 });

      // 3. 员工资料卡片
      Column({ space: 10 }) {
        Text('员工资料')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .margin({ bottom: 10 });

        Row() {
          Text('工号：')
            .fontSize(16);
          Text('00123')
            .fontSize(16)
            .fontWeight(FontWeight.Bold);
        }

        Row() {
          Text('部门：')
            .fontSize(16);
          Text('技术部')
            .fontSize(16)
            .fontWeight(FontWeight.Bold);
        }

        Row() {
          Text('职位：')
            .fontSize(16);
          Text('前端开发工程师')
            .fontSize(16)
            .fontWeight(FontWeight.Bold);
        }
      }
      .width('90%')
      .padding(20)
      .backgroundColor('#f9f9f9')
      .borderRadius(10)
      .shadow({ radius: 5, color: '#cccccc', offsetX: 2, offsetY: 2 });
    }
    .width('100%')
    .height('100%')
    .padding(10)
    .backgroundColor('#ffffff')
    .alignItems(HorizontalAlign.Center);
  }
}
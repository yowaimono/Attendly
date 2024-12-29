import router from '@ohos.router';

import HistoryPage from './History';
import ProfilePage from './Profile';
import HomeIndexPage from './HomeIndex';
@Entry
@Component
struct MainPage {
  @State currentPage: string = 'HomeIndexPage'; // 当前子页面

  // 切换子页面
  switchPage(page: string) {
    this.currentPage = page;
  }

  build() {
    Column() {
      // 顶部 Header
      Row({ space: 10 }) {
        Text('江水考勤')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)

          .layoutWeight(1) // 标题居中
          .textAlign(TextAlign.Center);

        Text('...') // 使用文本作为更多按钮的占位符
          .fontSize(24)
          .onClick(() => {
            console.log('点击了更多');
          });
      }
      .width('100%')
      .padding(10)
      .backgroundColor($r('app.color.theme_color'));

      // 中间内容区域（子路由容器）
      Stack() {
        if (this.currentPage === 'HomeIndexPage') {
          HomeIndexPage();
        } else if (this.currentPage === 'HistoryPage') {
          HistoryPage();
        } else if (this.currentPage === 'ProfilePage') {
          ProfilePage();
        }
      }
      .width('100%')
      .height('100%')
      .layoutWeight(1); // 占据剩余空间

      // 底部导航栏
      Row({ space: 20 }) {
        Text('主页')
          .onClick(() => {
            this.switchPage('HomeIndexPage'); // 切换到主页
          });

        Text('历史')
          .onClick(() => {
            this.switchPage('HistoryPage'); // 切换到历史页
          });

        Text('我的')
          .onClick(() => {
            this.switchPage('ProfilePage'); // 切换到个人主页
          });
      }
      .width('100%')
      .padding(10)
      .backgroundColor($r('app.color.theme_color'))
      .justifyContent(FlexAlign.SpaceAround);
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#ffffff');
  }
}


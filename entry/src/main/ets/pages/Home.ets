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

  // 构建顶部 Header
  @Builder
  buildHeader() {
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
  }

  // 构建底部导航栏
  @Builder
  buildNavBar() {
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

  // 构建中间内容区域
  @Builder
  buildContent() {
    Stack() {
      if (this.currentPage === 'HomeIndexPage') {
        HomeIndexPage(); // 加载主页
      } else if (this.currentPage === 'HistoryPage') {
        HistoryPage(); // 加载历史页
      } else if (this.currentPage === 'ProfilePage') {
        ProfilePage(); // 加载个人主页
      } else {
        Text('页面未找到') // 默认页面
          .fontSize(20)
          .margin({ top: 20 });
      }
    }
    .width('100%')
    .height('100%')
    .layoutWeight(1); // 占据剩余空间
  }

  build() {
    Column() {
      // 顶部 Header
      this.buildHeader();

      // 中间内容区域
      this.buildContent();

      // 底部导航栏
      this.buildNavBar();
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#ffffff');
  }
}
import util from '@ohos.util'
import { NewsMenu } from '../model/NewsMenu'
import router from '@ohos.router';

@Component
export struct MainMenu {
  @Consume menuCurrentIndex: number
  menus: NewsMenu[] = [
    {
      text: '首页',
      index: 0,
      url: 'pages/NewsList',
      icon: "common/index.png",
      iconSelected: "common/indexSelected.png"
    },
    {
      text: '我的',
      index: 1,
      url: 'pages/login',
      icon: "common/me.png",
      iconSelected: "common/meSelected.png"
    }
  ]

  @Builder NavigationTitle() {
    Row() {
      Text("卓越新闻")
        .fontSize(30)
        .fontWeight(700)
        .margin({ top: 30 })
    }.width('100%')
    .justifyContent(FlexAlign.Center)
  }

  @Builder NavigationToolbar() {
    Row() {
      ForEach(this.menus, (item: NewsMenu) => {
        Column() {
          Image(this.menuCurrentIndex === item.index ? item.iconSelected : item.icon)
            .width(42)
            .height(42)
          Text(item.text)
            .fontSize(16)
            .fontColor(this.menuCurrentIndex === item.index ? Color.Red : Color.Black)
        }.width("50%")
        .height(100)
        .onClick(() => {
          this.menuCurrentIndex = item.index
          router.replaceUrl({ url: item.url })
        })
      })
    }
  }

  build() {
    Column() {
      Navigation() {

      }.title(this.NavigationTitle())
      .toolBar(this.NavigationToolbar())
    }
    .width('100%')
  }
}
import { News } from '../model/News'
import { NewsType } from '../model/NewsType'
import { MainMenu } from './MainMenu'
import NewsModel from '../model/NewsModel'
import NewsTypeModel from '../model/NewsTypeModel'

@Extend(Image) function icon() {
  .height(10)
  .margin(5)
}

@Builder function newsListItem(item: News) {
  Navigator({ target: "pages/NewDetails", type: NavigationType.Push }) {
    Row() {
      Column() {
        Text(item.title)
          .fontSize(16)
        Row() {
          Row() {
            Image($r("app.media.comment"))
              .icon()

            Text(item.commentsCount + "")
              .fontSize(9)
              .margin({ right: 5 })
            Text("澎湃新闻")
              .fontSize(9)
          }

          Row() {
            Image($r("app.media.friend"))
              .icon()
            Text("好友")
              .fontSize(9)
              .margin({ right: 5 })
            Image($r("app.media.icon"))
              .icon()
            Text("海报")
              .fontSize(9)
              .margin({ right: 5 })
          }
        }.width("100%")
        .justifyContent(FlexAlign.SpaceBetween)
      }.height(100)
      .width('60%')
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ right: 5 })

      // Image('http://news-protal.oss-cn-beijing.aliyuncs.com/2a2ca06c-01c7-460e-8bbf-658c92b2ddd1.webp')
      Image(item.imageURL)
        .height(100)
        .width('40%')
        .borderRadius(5)
    }
  }
  .params(item)
}

@Entry
@Component
struct NewsList {
  @State message: string = 'Hello World'
  @Provide menuCurrentIndex: number = 0
  isLoading: boolean = false
  @State news: News[] = []
  @State newsTypeID: number[] = []
  @State newsTypes: NewsType[] = []

  aboutToAppear() {
    this.loadNewsInfo()
  }

  @State currentIndex: number = 0

  @Builder tabBuilder(typeName: string, index: number) {
    Column() {
      Text(typeName)
        .fontSize(this.currentIndex === index ? 18 : 16)
        .fontWeight(this.currentIndex === index ? 800 : 400)
        .margin({ bottom: 7 })
      Divider()
        .color(Color.Red)
        .width('35%')
        .opacity(this.currentIndex === index ? 1 : 0)
        .strokeWidth(3)
    }
  }

  build() {
    Stack() {
      MainMenu()
      Column() {
        Tabs({ barPosition: BarPosition.Start }) {
          ForEach(this.newsTypes, (newsType, index) => {
            TabContent() {
              Column() {
                List({ space: 10 }) {
                  ForEach(this.news.filter(i => i.newsTypeID === newsType.newsTypeID), item => {
                    ListItem() {
                      newsListItem(item)
                    }
                    .padding(5)
                    .margin(10)
                    .backgroundColor('#F5F5F5')
                    .borderRadius(10)
                  })
                }
                .width('100%')
                .backgroundColor(Color.White)
                .borderRadius(10)
                .layoutWeight(1)
                .onReachEnd(() => {
                  console.log('触底了')
                  if (!this.isLoading) {
                    this.isLoading = true
                    NewsModel.page++
                    this.loadNewsInfo()
                  }
                })
              }.justifyContent(FlexAlign.Start)
              .height('100%')
            }.tabBar(this.tabBuilder(newsType.typeName, index))
          })
        }.onChange((index) => {
          this.currentIndex = index
        })
      }
      .width('100%')
      .padding({ top: 60, left: 10, right: 10 })
      .height('80%')
      .backgroundColor('#F5F5F5')
    }
  }

  loadNewsInfo() {
    NewsModel.getNewsList()
      .then(news => {
        news.forEach(item => {
          console.log(JSON.stringify(item))
        })
        this.news = this.news.concat(news)
      })
      .catch(error => {
        console.error("获取新闻列表时发生错误:", error);
      });

    let newsTypeID = [1, 2, 3, 4, 5, 6]
    this.newsTypeID = newsTypeID

    let newsTypePromises = newsTypeID.map(id => NewsTypeModel.getNewsType(id));
    Promise.all(newsTypePromises)
      .then(newsTypes => {
        newsTypes.forEach(item => {
          console.log(`完整的新闻类型对象:`, JSON.stringify(item));
        });
        this.newsTypes = [].concat(...newsTypes) // Flatten the array if necessary
      })
      .catch(error => {
        console.error('获取新闻类型时出错:', error);
      });
  }
}

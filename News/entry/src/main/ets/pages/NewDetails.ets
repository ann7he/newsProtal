import router from '@ohos.router'
import hilog from '@ohos.hilog'
import { News } from '../model/News'
import { CommentDao } from '../dao/CommentDao';

@Entry
@Component
struct NewsDetail2 {
  @Provide newsId: number = 0
  news: News
  // 控制自定义弹窗的打开和关闭
  commentDialogController: CustomDialogController = new CustomDialogController({
    builder: CustomDialogComments(),
    alignment: DialogAlignment.Bottom
  })

  build() {
    Column() {
      Scroll() {
        Column({ space: 5 }) {
          //标题
          Row({ space: 5 }) {
            Image($r('app.media.app_icon'))
              .height(20)
            Text(this.news.title)
              .fontSize(25)
              .fontWeight(600)
          }
          .alignItems(VerticalAlign.Top)
          .padding(5)

          //副标题
          Row({ space: 5 }) {
            Text("澎湃新闻")
              .fontColor(Color.Gray)
            Text(this.news.publishTime)
              .fontColor(Color.Gray)

            Image($r('app.media.view'))
              .height(20)
              .margin({ left: 25 })

            Text(this.news.views.toString())
              .fontColor(Color.Gray)
          }
          .justifyContent(FlexAlign.Start)
          .width('100%')
          .padding(15)

          //图片
          // Image(this.news.imageURL)
          Image('http://news-protal.oss-cn-beijing.aliyuncs.com/2a2ca06c-01c7-460e-8bbf-658c92b2ddd1.webp')
            .width('100%')
          Text(this.news.content)
            .fontSize(18)
            .margin({ top: 20 })
          //正文
        }
        .padding(20)
      }.height('90%')
      .align(Alignment.TopStart)

      Row({ space: 10 }) {
        // 评论输入框
        Row() {
          Row() {
            Image($r('app.media.icon'))
              .width(20)
            Text("我来说两句")
          }

          Image($r('app.media.icon'))
            .width(20)
        }
        .width('60%')
        .backgroundColor('#f1f2f3')
        .justifyContent(FlexAlign.SpaceBetween)
        .height(40)
        .padding(8)
        .borderRadius(20)
        .onClick(() => {
          this.commentDialogController.open()
        })
        // 评价列表图标
        Badge({ value: this.news.commentsCount + "", style: { badgeSize: 15, badgeColor: Color.Red } }) {
          Image($r("app.media.comment"))
            .width(30)
        }

        Badge({ value: this.news.likes + "", style: { badgeSize: 15, badgeColor: Color.Red } }) {
          Image($r("app.media.like"))
            .width(30)
            .margin({ left: 5 })
        }

        Image($r("app.media.share1"))
          .width(30)
      }
      .width('90%')
      .padding(20)
    }
  }

  //当页面显示的时候执行
  aboutToAppear() {
    //获取数据
    let news = router.getParams()
    hilog.info(0x0000, 'testTag', '%{public}s', JSON.stringify(router.getParams()))
    this.news = new News(news['newsID'], news['title'], news['content'], news['publishTime'], news['newsTypeID'],
      news['views'], news['likes'], news['commentsCount'], news['status'], news['imageURL'])
    this.newsId = news['id']
    // this.news.views = this.news.views + 1;
  }
}
//用户评论
@CustomDialog
struct CustomDialogComments {
  // 负责弹出窗是否显示
  commentDialogController: CustomDialogController
  @State commentText: string = ""
  @Consume newsId: number

  build() {
    Column() {
      Row() {
        Text('X')
          .fontSize(20)
          .onClick(() => {
            this.commentDialogController.close()
          })
        Text('评论')
          .fontSize(16)
          .fontWeight(800)
        Button('发表')
          .backgroundColor(this.commentText.length > 0 ? Color.Red : "#f1f2f3")
          .fontColor(this.commentText.length > 0 ? Color.White : Color.Gray)
      }.width('100%')
      .padding(10)
      .justifyContent(FlexAlign.SpaceBetween)

      TextInput({ placeholder: '优质评论将在这里显示' })
        .height(150)
        .align(Alignment.TopStart)
        .onChange((value) => {
          this.commentText = value
        })
    }
  }

  // aboutToAppear() {
  //   let commentDao: CommentDao = new CommentDao()
  //   commentDao.getById(this.newsId,())
  //
  // }
}
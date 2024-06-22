import { CommentDao } from '../dao/CommentDao'

@Entry
@Component
struct Test {
  build() {
    Row() {
      Column() {
        Button("点击存储首选项")
          .onClick(() => {
            let commentDao: CommentDao = new CommentDao()
            commentDao.put(1, "123")
          })
        Button("点击获取首选项")
          .onClick(() => {
            let commentDao: CommentDao = new CommentDao()
            commentDao.getById(1)
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}
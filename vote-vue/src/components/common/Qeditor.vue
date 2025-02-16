<template>
  <div class="qeidtor">
    <div class="upload-img-container">
      <el-upload
        class="avatarUploader"
        action="http://localhost:8443/api/admin/candidate/covers"
        with-credentials
        :show-file-list="false"
        :on-success="handleAvatarSuccess"
        :before-upload="beforeAvatarUpload">
        <img v-if="imageUrl" :src="imageUrl" class="avatar" />
        <i v-else class="el-icon-plus avatar-uploader-icon"></i>
      </el-upload>
    </div>

    <quill-editor
      class="el_quill"
      id="myQuillEditorId"
      v-model="content"
      ref="myQuillEditor"
      :options="editorOption"
      @blur="onEditorBlur($event)" @focus="onEditorFocus($event)"
      @change="onEditorChange($event)">
    </quill-editor>
    <div>
    </div>
  </div>
</template>

<script>
  const toolbarOptions = [
    ['bold', 'italic', 'underline', 'strike'], //加粗，斜体，下划线，删除线
    ['blockquote', 'code-block'], //引用、代码块儿
    [{ header: 1 }, { header: 2 }], //标题，键值对的形式；1、2表示字体大小
    [{ list: 'ordered' }, { list: 'bullet' }], //列表
    [{ script: 'sub' }, { script: 'super' }], //上下标
    // [{ indent: '-1' }, { indent: '+1' }], //缩进
    [{ direction: 'rtl' }], //文本方向
    [{ size: ['small', false, 'large', 'huge'] }], //字体大小
    [{ header: [1, 2, 3, 4, 5, 6, false] }], //几级标题
    [{ color: [] }, { background: [] }], //字体颜色，字体背景颜色
    [{ font: [] }], //字体
    [{ align: [] }], //对齐方式
    ['clean'], //清除字体样式
    ['image'], //上传图片、上传视频(video)、超链接(link)
  ]
  export default {
    name:'Qeditor',
    data(){
      return {
        content: `<p></p>`,
        imageUrl: '',
        editorOption: {
          modules: {
            clipboard: {
              // 粘贴版，处理粘贴时候的自带样式
              matchers: [[Node.ELEMENT_NODE, this.HandleCustomMatcher]],
            },
            toolbar: {
              container: toolbarOptions, // 工具栏
              handlers: {
                image: function(value) {
                  if (value) {
                    // 获取隐藏的上传图片的class，不一定是.el-icon-plus。触发上传图片事件
                    document.querySelector('.el-icon-plus').click()
                  } else {
                    this.quill.format('image', false)
                  }
                },
              },
            },
          },
          placeholder: '',
          theme:'snow'
        },


      }
    },
    computed: {},
    async mounted() {},
    methods: {
      handleAvatarSuccess(res) {
        // 图片上传成功后的回调
        let quill = this.$refs.myQuillEditor.quill
        // 上传服务成功后，按根据光标位置把图片插入编辑器中
        if (res) {
          // 获取光标所在位置,data.url表示上传服务后返回的图片地址
          let length = quill.getSelection().index
          // 插入图片，data.url为服务返回的图片链接地址
          quill.insertEmbed(length, 'image', res)
          // 调整光标到最后
          quill.setSelection(length + 1)
        } else {
          this.$message.closeAll()
          this.$message.error('图片插入失败')
        }
      },
      beforeAvatarUpload(data) {
        // 思路：上传图片至服务后，拿到返回的图片地址。直接创建image标签插入光标所在的位置
        // 图片上传服务(本地服务或者阿里云服务)
        // 获取富文本组件实例

      },
      onEditorReady(editor) { // 准备编辑器
      },
      onEditorBlur(){}, // 失去焦点事件
      onEditorFocus(){}, // 获得焦点事件
      onEditorChange(el){// 内容改变事件
      },
      saveHtml:function(event){
        alert(this.content);
      },
      HandleCustomMatcher(node, Delta) {
        // 文字、图片等，从别处复制而来，清除自带样式，转为纯文本
        let ops = []
        Delta.ops.forEach(op => {
          if (op.insert && typeof op.insert === 'string') {
            ops.push({
              insert: op.insert,
            })
          }
        })
        Delta.ops = ops
        return Delta
      },
    },

  }
</script>

<style>
  .qeidtor{
    height: 420px;
  }
  .el_quill{
    height:380px;
  }


  .ql-snow .ql-tooltip[data-mode=link]::before {
    content: "请输入链接地址:" !important;
  }
  .ql-snow .ql-tooltip.ql-editing a.ql-action::after {
    border-right: 0px;
    content: '保存' !important;
    padding-right: 0px;
  }
  .ql-snow .ql-tooltip[data-mode=video]::before {
    content: "请输入视频地址:" !important;
  }
  .ql-snow .ql-picker.ql-size .ql-picker-label::before,
  .ql-snow .ql-picker.ql-size .ql-picker-item::before {
    content: '14px' !important;
  }
  .ql-snow .ql-picker.ql-size .ql-picker-label[data-value=small]::before,
  .ql-snow .ql-picker.ql-size .ql-picker-item[data-value=small]::before {
    content: '10px' !important;
  }
  .ql-snow .ql-picker.ql-size .ql-picker-label[data-value=large]::before,
  .ql-snow .ql-picker.ql-size .ql-picker-item[data-value=large]::before {
    content: '18px' !important;
  }
  .ql-snow .ql-picker.ql-size .ql-picker-label[data-value=huge]::before,
  .ql-snow .ql-picker.ql-size .ql-picker-item[data-value=huge]::before {
    content: '32px' !important;
  }

  .ql-snow .ql-picker.ql-header .ql-picker-label::before,
  .ql-snow .ql-picker.ql-header .ql-picker-item::before {
    content: '文本' !important;
  }
  .ql-snow .ql-picker.ql-header .ql-picker-label[data-value="1"]::before,
  .ql-snow .ql-picker.ql-header .ql-picker-item[data-value="1"]::before {
    content: '标题1' !important;
  }
  .ql-snow .ql-picker.ql-header .ql-picker-label[data-value="2"]::before,
  .ql-snow .ql-picker.ql-header .ql-picker-item[data-value="2"]::before {
    content: '标题2' !important;
  }
  .ql-snow .ql-picker.ql-header .ql-picker-label[data-value="3"]::before,
  .ql-snow .ql-picker.ql-header .ql-picker-item[data-value="3"]::before {
    content: '标题3' !important;
  }
  .ql-snow .ql-picker.ql-header .ql-picker-label[data-value="4"]::before,
  .ql-snow .ql-picker.ql-header .ql-picker-item[data-value="4"]::before {
    content: '标题4' !important;
  }
  .ql-snow .ql-picker.ql-header .ql-picker-label[data-value="5"]::before,
  .ql-snow .ql-picker.ql-header .ql-picker-item[data-value="5"]::before {
    content: '标题5' !important;
  }
  .ql-snow .ql-picker.ql-header .ql-picker-label[data-value="6"]::before,
  .ql-snow .ql-picker.ql-header .ql-picker-item[data-value="6"]::before {
    content: '标题6' !important;
  }

  .ql-snow .ql-picker.ql-font .ql-picker-label::before,
  .ql-snow .ql-picker.ql-font .ql-picker-item::before {
    content: '标准字体' !important;
  }
  .ql-snow .ql-picker.ql-font .ql-picker-label[data-value=serif]::before,
  .ql-snow .ql-picker.ql-font .ql-picker-item[data-value=serif]::before {
    content: '衬线字体' !important;
  }
  .ql-snow .ql-picker.ql-font .ql-picker-label[data-value=monospace]::before,
  .ql-snow .ql-picker.ql-font .ql-picker-item[data-value=monospace]::before {
    content: '等宽字体' !important;
  }

  .upload-img-container{
    display: none;
  }
</style>

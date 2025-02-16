<template>
      <el-dialog
        title="修改描述"
        :visible.sync="dialogFormVisible"
        :modal-append-to-body="false"
        @close="clear"
        :width=dialogWidth>
        <qeditor ref="qeditor"></qeditor>
        <div style="padding-top: 50px;margin-top: 20px">
          <el-button type="primary" @click="submit">确定</el-button>
          <el-button @click="clear">取消</el-button>
        </div>
      </el-dialog>
</template>

<script>
    import Qeditor from "../../common/Qeditor";
    export default {
        name: "EditDesc",
        components: {Qeditor},
        data(){
          return{
            dialogFormVisible:false,
            id:0,
            num:0,
            content:'',
            coverUrl:'',
            videoUrl:'',
            title:'',
            state:'',
            voteItemId:0,
            dialogWidth:'500px',
          }
      },
      mounted(){
          this.handleBindContent()
          window.onresize = () => {
            return (() => {
              this.setDialogWidth()
            })()
          }
      },
      methods:{
        clear(){
          this.dialogFormVisible = false
          this.$refs.qeditor.content = ''
        },
        submit(){
          this.content = this.$refs.qeditor.content
          this.$axios.put('/admin/candidate/'+this.voteItemId,{
            num: this.num,
            title:this.title,
            itemDesc : this.content,
            aid:this.$store.state.curCreateActivity.id,
            coverUrl:this.coverUrl,
            videoUrl:this.videoUrl,
            state:this.state
          }).then(resp =>{
            if(resp && resp.data.code === 200){
              this.$emit('onSubmit')
              this.clear()
            }
          })
        },
        handleBindContent(){
          this.$refs.qeditor.content = this.content
        },
        setDialogWidth() {
          let val = document.body.clientWidth
          const def = 500 // 默认宽度
          if (val < def) {
            this.dialogWidth = '100%'
          } else {
            this.dialogWidth = def + 'px'
          }
        },
      }
    }
</script>

<style scoped>

</style>

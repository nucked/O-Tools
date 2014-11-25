#include "xiaomitool.h"
#include "ui_xiaomitool.h"

XiaomiTool::XiaomiTool(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::XiaomiTool)
{
    ui->setupUi(this);
}

XiaomiTool::~XiaomiTool()
{
    delete ui;
}

void XiaomiTool::on_RestoreB_clicked()
{
    system ("./run.sh --backup");
}


void XiaomiTool::on_BackupB_clicked()
{
    system ("./run.sh --restore");
}


void XiaomiTool::on_PushB_clicked()
{
    system ("./run.sh --push");
}

void XiaomiTool::on_CameraB_clicked()
{
    system ("./run.sh --camera");
}

void XiaomiTool::on_APKB_clicked()
{
    system ("./run.sh --apk");
}

void XiaomiTool::on_ShellB_clicked()
{
    system ("./run.sh --shell");
}

void XiaomiTool::on_SRecB_clicked()
{
    system ("./run.sh --srec");
}

void XiaomiTool::on_RunTB_clicked()
{
    system ("./run.sh --runtime");
}

void XiaomiTool::on_RecoveryB_clicked()
{
    system ("./run.sh --recovery");
}

void XiaomiTool::on_ZipB_clicked()
{
    system ("./run.sh --flash");
}

void XiaomiTool::on_RootB_clicked()
{
    system ("./run.sh --root");
}

void XiaomiTool::on_FastBootB_clicked()
{
    system ("./run.sh --fastboot");
}

void XiaomiTool::on_WDataB_clicked()
{
    system ("./run.sh --wipe");
}

void XiaomiTool::on_DeviceB_clicked()
{
    system ("./run.sh --device");
}

void XiaomiTool::on_ToolB_clicked()
{
    system ("./run.sh --about");
}

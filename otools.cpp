#include "otools.h"
#include "ui_otools.h"
#include <QFileDialog>
#include <QMessageBox>
#include <stdlib.h>

OTools::OTools(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::OTools)
{
    ui->setupUi(this);
}

OTools::~OTools()
{
    delete ui;
}

// Device Selection

void OTools::on_bacon_clicked()
{
    ui->modbox->setEnabled(true);
    ui->recbox->setEnabled(true);
    ui->filebox->setEnabled(true);
    ui->backbox->setEnabled(true);
    ui->UnlockB->setEnabled(true);
    ui->LockB->setEnabled(true);
    ui->EfsB->setEnabled(true);
    ui->label->setVisible(false);
}

void OTools::on_find7_clicked(){
    ui->modbox->setEnabled(true);
    ui->recbox->setEnabled(true);
    ui->filebox->setEnabled(true);
    ui->backbox->setEnabled(true);
    ui->label->setVisible(false);
    ui->UnlockB->setEnabled(false);
    ui->LockB->setEnabled(false);
    ui->EfsB->setEnabled(false);
}

void OTools::on_find5_clicked()
{
    ui->modbox->setEnabled(true);
    ui->recbox->setEnabled(true);
    ui->filebox->setEnabled(true);
    ui->backbox->setEnabled(true);
    ui->label->setVisible(false);
    ui->UnlockB->setEnabled(false);
    ui->LockB->setEnabled(false);
    ui->EfsB->setEnabled(false);
}

void OTools::on_n1_clicked()
{
    ui->modbox->setEnabled(true);
    ui->recbox->setEnabled(true);
    ui->filebox->setEnabled(true);
    ui->backbox->setEnabled(true);
    ui->label->setVisible(false);
    ui->UnlockB->setEnabled(false);
    ui->LockB->setEnabled(false);
    ui->EfsB->setEnabled(false);
}

// ToolBar

void OTools::on_actionDisclaimer_triggered()
{
    QMessageBox::critical(this,tr("Disclaimer"),"This program has enough knowledge to brick your device, destroy your computer, void warrany, eat cats and burn your flowers. The developer disclaim every damange caused from the usage of this program.");
}

void OTools::on_actionAbout_triggered()
{
    QMessageBox::about(this,tr("About OTools"),"©2014 Joey Rizzoli (@linuxx)\nSources: https://github.com/linuxxxxx/OTools\nOTools is an opensource software that has the goal to provide a fast, safe and user friendly tool to manage your Oppo or OnePlus Device.");
}

void OTools::on_actionUpdate_triggered()
{
    QMessageBox::information(this,tr("Update"),"Updating OTools");
}

// Buttons

//Backup

void OTools::on_BackupB_clicked()
{
    /* TODO:
     * File Save
     * Confirm dialog
     * Command
     * Return Dialog
     */
}

void OTools::on_RestoreB_clicked()
{
    QString backfile=QFileDialog::getOpenFileName(
                this,
                tr("Choose File"),
                "~"
                "Backups (*.ab);;All Files (*.*)"
                );
    QMessageBox::information(this,tr("Restore Backup"),backfile,"OK");
    const char *backupf = qPrintable(backfile);
    setenv("backupf", backupf, true);
    system("adb restore $backupf");
    if (system?!=0) QMessageBox::information(this,tr("Done"),"Backup restored sucesfully!","OK");
    else QMessageBox::error(this,tr("Error"),"An error occured while restoring the backup","OK");
}

//Files

void OTools::on_PushB_clicked(){
    QString pushfile=QFileDialog::getOpenFileName(
                this,
                tr("Choose File"),
                "~"
                "All Files (*.*)"
                );
    QMessageBox::information(this,tr("Push File"),pushfile,"OK");
    const char *file = qPrintable(pushfile);
    setenv("pushfile", file, true);
    system("adb push $pushfile /sdcard/");
    if (system?!=0) QMessageBox::information(this,tr("Done"),"File pushed sucesfully!","OK");
    else QMessageBox::error(this,tr("Error"),"An error occured while pushing the file","OK");
}

void OTools::on_PullB_clicked(){
    /* TODO:
     * think about this
     */
}

void OTools::on_CamB_clicked(){
    /* TODO:
     * something similar to push, but instead of selecting a file, make user select the destination folder for the photos
     */
}

//Recovery

void OTools::on_pushButton_3_clicked()
{
    /* TODO:
     * if install zip is cheked enable the select button, export the path as bash var, add the flag to openrecovery script
     * if wipe data is checked add a flag to openrecovery script
     * if backup is checked add a flag to openrecovery script << THIS MUST BE THE FIRST
     */
}

// Advanced stuffs

//MOD

void OTools::on_UnlockB_clicked()
{
    /* TODO:
     * Dialog warning user about format userdata
     * Reboot bloader and unlock
     * Dialog and reboot
     */
}

void OTools::on_LockB_clicked()
{
    /* TODO:
     * Dialog to confirm
     * Reboot and lock with oem-lock
     */
}

void OTools::on_FBootB_clicked()
{
    /* TODO:
     * FilePicker
     * Boot to fb mode and sideload
     */
}

void OTools::on_FlashBootB_clicked()
{
    /* TODO:
     * FilePicker
     * flash
     * boot
     */
}

void OTools::on_RecoveryB_clicked()
{
    /* TODO:
     * as FastBootB
     */
}

void OTools::on_FBFlashB_clicked()
{
    /* TODO:
     * ask partition name (choose from an array?)
     * Filepicker
     * flash
     */
}

void OTools::on_RootB_clicked()
{
    /* TODO:
     * boot recoveryimg
     * flash supersu.zip
     */
}

void OTools::on_LogoB_clicked()
{
    /* TODO:
     * FilePicker
     * Flash
     */
}

void OTools::on_EfsB_clicked()
{
    /* TODO:
     * check on xda block names
     * boot recovery-img
     * dd parts to sd
     */
}

void OTools::on_SRECB_clicked()
{
    /* TODO:
     * ask a filename
     * Dialog with a button to click when user wants to quit registration?? (killall -9 adb && adb start-server)
     */
}

void OTools::on_ShellB_clicked()
{
    /* TODO:
     * open xterm with adb shell << I don't like this
     */
}

void OTools::on_ApkB_clicked()
{
    /* TODO:
     * Filepicker
     */
}

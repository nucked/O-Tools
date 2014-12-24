#include "otools.h"
#include "ui_otools.h"
#include <QFileDialog>
#include <QMessageBox>
#include <stdlib.h>
QString device("unknown");

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
    device="bacon";
    setenv("adbdevice", device, true);
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
    device="find7";
    setenv("adbdevice", device, true);
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
    device="find5";
    setenv("adbdevice", device, true);
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
    device="n1";
    setenv("adbdevice", device, true);
}

// ToolBar

void OTools::on_actionDisclaimer_triggered()
{
    QMessageBox::about(this,tr("Disclaimer"),"This program has enough knowledge to brick your device, destroy your computer, void warrany, eat cats and burn your flowers. The developer disclaim every damange caused from the usage of this program.", "Close");
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
    //if (system? != 0) QMessageBox::information(this,tr("Done"),"Backup restored sucesfully!","OK");
    //else QMessageBox::information(this,tr("Error"),"An error occured while restoring the backup","OK");
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
    //if (system?!=0) QMessageBox::information(this,tr("Done"),"File pushed sucesfully!","OK");
    //else QMessageBox::error(this,tr("Error"),"An error occured while pushing the file","OK");
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
    QMessageBox::information(this,tr("Unlock Bootloader"),"You want to unlock the bootloader, this operation will erase all your personal content such as photos, apps and music, a backup is recommend! This operation may brick your device if something goes wrong","Continue");
    QMessageBox::about(this,tr("Unlock Bootloader"),"Plug your device in and wait until you'll see a 'done' message, if asked to allow unlock select yes.\n Press Next to start","Next");
    system("adb wait-for-device");
    system("adb reboot bootloader");
    system("fastboot devices");
    system("fastboot oem-unlock");
    // Dunno how that lk manages fb commands,
    QMessageBox::information(this,tr("Unlock Bootloader"),"Wait until the device completes the unlock operation, when it will say done, reboot","Done");
    /* TODO:
     * Dialog while executing system()
     */
}

void OTools::on_LockB_clicked()
{
    QMessageBox::information(this,tr("Lock Bootloader"),"You want to lock the bootloader, you won't be able to boot or flash img files until you'll re-unlock it! You won't loose any data.\n This operation may brick your device if something goes wrong","Continue");
    QMessageBox::about(this,tr("Lock Bootloader"),"Plug your device in and wait until you'll see a 'done' message, if asked to allow unlock select yes.\n Press Next to start","Next");
    system("adb wait-for-device");
    system("adb reboot bootloader");
    system("fastboot devices");
    system("fastboot oem-lock");
    // Dunno how that lk manages fb commands,
    QMessageBox::information(this,tr("Lock Bootloader"),"Wait until the device completes the lock operation, when it will say done, reboot","Done");
    /* TODO:
     * Dialog while executing system()
     */
}

void OTools::on_FBootB_clicked()
{
    QString fbboot=QFileDialog::getOpenFileName(
                this,
                tr("Choose File"),
                "~"
                "IMG files (*.img);;All Files (*.*)"
                );
    QMessageBox::information(this,tr("Fastboot Boot"),fbboot,"OK");
    const char *ffbboot = qPrintable(fbboot);
    QMessageBox::about(this,tr("Fastboot Boot"),"Plug your device in and wait until device boots the file.\n Press Next to start","Next");
    setenv("ffbboot", ffbboot, true);
    system("adb wait-for-device");
    system("adb reboot bootloader");
    system("fastboot devices");
    system("fastboot boot $ffbboot");
    /* TODO:
     * Dialog while executing system()
     */
}

void OTools::on_FlashBootB_clicked()
{
    QString fboot=QFileDialog::getOpenFileName(
                this,
                tr("Choose File"),
                "~"
                "IMG files (*.img);;All Files (*.*)"
                );
    QMessageBox::information(this,tr("Kernel Installer"),fboot,"OK");
    const char *ffboot = qPrintable(fboot);
    QMessageBox::about(this,tr("Kernel Installer"),"Plug your device in and wait until kernel is flashed, the device will reboot automatically.\n Press Next to start","Next");
    setenv("ffboot", ffboot, true);
    system("adb wait-for-device");
    system("adb reboot bootloader");
    system("fastboot devices");
    system("fastboot flash boot $ffboot");
    system("fastboot reboot");
    /* TODO:
     * Dialog while executing system()
     */
}

void OTools::on_RecoveryB_clicked()
{
    QString recovery=QFileDialog::getOpenFileName(
                this,
                tr("Choose File"),
                "~"
                "IMG files (*.img);;All Files (*.*)"
                );
    QMessageBox::information(this,tr("Kernel Installer"),fboot,"OK");
    const char *ffboot = qPrintable(fboot);
    QMessageBox::about(this,tr("Kernel Installer"),"Plug your device in and wait until kernel is flashed, the device will reboot automatically.\n Press Next to start","Next");
    setenv("ffboot", ffboot, true);
    system("adb wait-for-device");
    system("adb reboot bootloader");
    system("fastboot devices");
    system("fastboot flash boot $ffboot");
    system("fastboot reboot");
    /* TODO:
     * Ask user if he/she already have a recovery.img file, if not use a local twrp
     * Dialog while executing system()
     */
}

void OTools::on_FBFlashB_clicked()
{
    /* TODO >>LATER<<:
     * ask partition name (choose from an array?)
     * Filepicker
     * flash
     */
}

void OTools::on_RootB_clicked()
{
    //TODO: add a unlocked-checker using fastboot oem device-info | grep 'Device unlocked: '
    QMessageBox::about(this,tr("Rooter"),"This operation will root your device. Your bootloader needs to be unlocked otherwhise most of the operations will fail.","Start");
    const char *updatezip("res/root.zip");
    setenv("updatezip", updatezip, true);
    system("adb wait-for-device");
    system("adb reboot bootloader");
    system("fastboot device");
    system("fastboot boot res/$adbdevice/recovery.img");
    // TODO: find a better way to inject openrecovery commands
    system("sh res/openrecovery.sh --sideload");
    QMessageBox::about(this,tr("Rooter"),"Done, device will complete the installation automatically, let it reboots once it's done.","Done");
    /* TODO:
     * Dialog while executing system()
     */

}

void OTools::on_LogoB_clicked()
{
    QString logo=QFileDialog::getOpenFileName(
                this,
                tr("Choose File"),
                "~"
                "Logo files (*.bin);;All Files (*.*)"
                );
    QMessageBox::information(this,tr("Logo Changer"),logo,"OK");
    const char *flogo = qPrintable(logo);
    QMessageBox::about(this,tr("Logo Changer"),"Plug your device in, and let it work, remember that the bootloader must be unlocked.\n Press Next to start","Next");
    setenv("flogo", flogo, true);
    system("adb wait-for-device");
    system("adb reboot bootloader");
    system("fastboot devices");
    system("fastboot flash LOGO $flogo");
    system("fastboot reboot");
    /* TODO:
     * Dialog while executing system()
     */
}

void OTools::on_EfsB_clicked()
{
    /* TODO:
     * check on xda files to backup
     * boot into tmp recovery
     * backup with dd= of=
     */

}

void OTools::on_SRECB_clicked()
{
    QMessageBox::about(this,tr("Screen Recorder"),"Plug your device in, press next to start the record.\n When you want to stop it, unplug the device and plug it in again.\n Press Next to start","Next");
    //freeze the program and update the suggestion text
    ui->backbox->setEnabled(false);
    ui->modbox->setEnabled(false);
    ui->recbox->setEnabled(false);
    ui->filebox->setEnabled(false);
    system("adb shell screenrecord /sdcard/${date +'%F-%I-%H-%N'");
    ui->modbox->setEnabled(true);
    ui->recbox->setEnabled(true);
    ui->filebox->setEnabled(true);
    ui->backbox->setEnabled(true);
    /* TODO:
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
    QString apk=QFileDialog::getOpenFileName(
                this,
                tr("Choose File"),
                "~"
                "Apk files (*.apk);;All Files (*.*)"
                );
    QMessageBox::information(this,tr("Apk Installer"),apk,"OK");
    const char *fapk = qPrintable(apk);
    QMessageBox::about(this,tr("Apk Installer"),"Plug your device in and wait until the apps get installed.\n Press Next to start","Next");
    setenv("ffboot", ffboot, true);
    system("adb wait-for-device");
    system("adb install $fapk")
    // check if failed or not
    setenv("ffboot", ffboot, true);
    QMessageBox::information(this,tr("Apk Installer"),"Done!","OK");
}

Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 566E235876F
	for <lists+linux-scsi@lfdr.de>; Thu,  8 Apr 2021 16:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbhDHOte (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 8 Apr 2021 10:49:34 -0400
Received: from labrats.qualcomm.com ([199.106.110.90]:44218 "EHLO
        labrats.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbhDHOtd (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 8 Apr 2021 10:49:33 -0400
IronPort-SDR: T4VoAZa5g9En8wWZE6GJwDXcYch+OWOrL0aVlauWATkaZLN0Ht3KwTmKNIZjKaMqswgtXscPN1
 LkchsiUWCjvEElRYjhwx+u1CgC/iKVI2laWs3VGvGk60gsVFtNmx/nmCxLonkzZ5OFRpmg5MEU
 tjx0FAkL2+wsXSwNu1rFj+ggNuq6dKnRNcDUyUGl0vH01Crr4C8DsWmjnKVhKgUmBMEnvJ1rlD
 mc/LDEFE3Jt3V3+2ootmQwVAwA0wOvJEGK7Npoa5aEVKA8zZPAZoEJbVnRiusxwGTXer+QgNTe
 B04=
X-IronPort-AV: E=Sophos;i="5.82,206,1613462400"; 
   d="scan'208";a="47840387"
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by labrats.qualcomm.com with ESMTP; 08 Apr 2021 07:49:23 -0700
X-QCInternal: smtphost
Received: from wsp769891wss.qualcomm.com (HELO stor-presley.qualcomm.com) ([192.168.140.85])
  by ironmsg01-sd.qualcomm.com with ESMTP; 08 Apr 2021 07:49:22 -0700
Received: by stor-presley.qualcomm.com (Postfix, from userid 92687)
        id 51A1520FA1; Thu,  8 Apr 2021 07:49:22 -0700 (PDT)
From:   Asutosh Das <asutoshd@codeaurora.org>
To:     cang@codeaurora.org, martin.petersen@oracle.com,
        adrian.hunter@intel.com, linux-scsi@vger.kernel.org
Cc:     Asutosh Das <asutoshd@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support)
Subject: [PATCH v17 0/2] Enable power management for ufs wlun 
Date:   Thu,  8 Apr 2021 07:49:18 -0700
Message-Id: <cover.1617893198.git.asutoshd@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patch attempts to fix a deadlock in ufs while sending SSU.
Recently, blk_queue_enter() added a check to not process requests if the
queue is suspended. That leads to a resume of the associated device which
is suspended. In ufs, that device is ufs device wlun and it's parent is
ufs_hba. This resume tries to resume ufs device wlun which in turn tries
to resume ufs_hba, which is already in the process of suspending, thus
causing a deadlock.

This patch takes care of:
* Suspending the ufs device lun only after all other luns are suspended
* Sending SSU during ufs device wlun suspend
* Clearing uac for rpmb and ufs device wlun
* Not sending commands to the device during host suspend

v16 -> v17:
- Addressed Adrian's & Daejun's comments

v15 -> v16:
- Brought back the missing changes
  * Added scsi_autopm_[get/put] to ufs_debugfs[get/put]_user_access()
  * Fix ufshcd_wl_poweroff()

v14 -> v15:
- Rebased on 5.13/scsi-staging

v13 -> v14:
- Addressed Adrian's comments
  * Rebased it on top of scsi-next
  * Added scsi_autopm_[get/put] to ufs_debugfs[get/put]_user_access()
  * Resume the device in ufshcd_remove()
  * Unregister ufs_rpmb_wlun before ufs_dev_wlun
  * hba->shutting_down moved to ufshcd_wl_shutdown()

v12 -> v13:
- Addressed Adrian's comments
  * Paired pm_runtime_get_noresume() with pm_runtime_put()
  * no rpm_autosuspend for ufs device wlun
  * Moved runtime-pm init functionality to ufshcd_wl_probe()
- Addressed Bart's comments
  * Expanded abbrevs in commit message

v11 -> v12:
- Addressed Adrian's comments
  * Fixed ahit for Mediatek driver
  * Fixed error handling in ufshcd_core_init()
  * Tested this patch and the issue is still seen.

v10 -> v11:
- Fixed supplier suspending before consumer race
- Addressed Adrian's comments
  * Added proper resume/suspend cb to ufshcd_auto_hibern8_update()
  * Cosmetic changes to ufshcd-pci.c
  * Cleaned up ufshcd_system_suspend()
  * Added ufshcd_debugfs_eh_exit to ufshcd_core_init()

v9 -> v10:
- Addressed Adrian's comments
  * Moved suspend/resume vops to __ufshcd_wl_[suspend/resume]()
  * Added correct resume in ufs_bsg

v8 -> v9:
- Addressed Adrian's comments
  * Moved link transition to __ufshcd_wl_[suspend/resume]()
  * Fixed the other minor comments

v7 -> v8:
- Addressed Adrian's comments
  * Removed separate autosuspend delay for ufs-device lun
  * Fixed the ee handler getting scheduled during pm
  * Always runtime resume in suspend_prepare()
  * Added CONFIG_PM_SLEEP where needed
  
v6 -> v7:
  * Resume the ufs device before shutting it down

v5 -> v6:
- Addressed Adrian's comments
  * Added complete() cb
  * Added suspend_prepare() and complete() to all drivers
  * Moved suspend_prepare() and complete() to ufshcd
  * .poweroff() uses ufhcd_wl_poweroff()
  * Removed several forward declarations
  * Moved scsi_register_driver() to ufshcd_core_init()

v4 -> v5:
- Addressed Adrian's comments
  * Used the rpmb driver contributed by Adrian
  * Runtime-resume the ufs device during suspend to honor spm-lvl
  * Unregister the scsi_driver in ufshcd_remove()
  * Currently shutdown() puts the ufs device to power-down mode
    so, just removed ufshcd_pci_poweroff()
  * Quiesce the scsi device during shutdown instead of remove

v3 RFC -> v4:
- Addressed Bart's comments
  * Except that I didn't get any checkpatch failures
- Addressed Avri's comments
- Addressed Adrian's comments
  * Added a check for deepsleep power mode
  * Removed a couple of forward declarations
  * Didn't separate the scsi drivers because in rpmb case it just sends uac
    in resume and it seemed pretty neat to me.
- Added sysfs changes to resume the devices before accessing


Asutosh Das (2):
  scsi: ufs: Enable power management for wlun
  ufs: sysfs: Resume the proper scsi device

 drivers/scsi/ufs/cdns-pltfrm.c     |   2 +
 drivers/scsi/ufs/tc-dwc-g210-pci.c |   2 +
 drivers/scsi/ufs/ufs-debugfs.c     |   6 +-
 drivers/scsi/ufs/ufs-debugfs.h     |   2 +-
 drivers/scsi/ufs/ufs-exynos.c      |   2 +
 drivers/scsi/ufs/ufs-hisi.c        |   2 +
 drivers/scsi/ufs/ufs-mediatek.c    |  12 +-
 drivers/scsi/ufs/ufs-qcom.c        |   2 +
 drivers/scsi/ufs/ufs-sysfs.c       |  30 +-
 drivers/scsi/ufs/ufs_bsg.c         |   6 +-
 drivers/scsi/ufs/ufshcd-pci.c      |  36 +--
 drivers/scsi/ufs/ufshcd.c          | 642 ++++++++++++++++++++++++++-----------
 drivers/scsi/ufs/ufshcd.h          |   6 +
 include/trace/events/ufs.h         |  20 ++
 14 files changed, 526 insertions(+), 244 deletions(-)

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.


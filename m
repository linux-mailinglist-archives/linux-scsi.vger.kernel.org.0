Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D36E10D096
	for <lists+linux-scsi@lfdr.de>; Fri, 29 Nov 2019 04:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfK2DDT (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 28 Nov 2019 22:03:19 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:38826 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726729AbfK2DDT (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 28 Nov 2019 22:03:19 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 47B7B1D6D8A002D4449A;
        Fri, 29 Nov 2019 11:03:14 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Fri, 29 Nov 2019
 11:03:05 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <martin.petersen@oracle.com>, <jejb@linux.vnet.ibm.com>
CC:     <linux-scsi@vger.kernel.org>, <dan.j.williams@intel.com>,
        <jthumshirn@suse.de>, <hch@lst.de>, <john.garry@huawei.com>,
        Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] scsi: libsas: stop discovering if oob mode is disconnected
Date:   Fri, 29 Nov 2019 11:24:13 +0800
Message-ID: <20191129032413.36092-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The discovering of sas port is driving by workqueue in libsas. When
libsas is processing port events or phy events in workqueue, new evnets
may rise up and change the state of some structures such as asd_sas_phy.
This may cause some problems such as follows:

==>thread 1                       ==>thread 2

                                  ==>phy up
                                  ==>phy_up_v3_hw()
                                    ==>oob_mode = SATA_OOB_MODE;
                                  ==>phy donw quickly
                                  ==>hisi_sas_phy_down()
                                    ==>sas_ha->notify_phy_event()
                                    ==>sas_phy_disconnected()
                                      ==>oob_mode = OOB_NOT_CONNECTED
==>workqueue wakeup
==>sas_form_port()
  ==>sas_discover_domain()
    ==>sas_get_port_device()
      ==>oob_mode is OOB_NOT_CONNECTED and device
         is wrongly taken as expander

This at last lead to the panic when libsas trying to issue a command to
discover the device.

[183047.614035] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000058
[183047.622896] Mem abort info:
[183047.625762]   ESR = 0x96000004
[183047.628893]   Exception class = DABT (current EL), IL = 32 bits
[183047.634888]   SET = 0, FnV = 0
[183047.638015]   EA = 0, S1PTW = 0
[183047.641232] Data abort info:
[183047.644189]   ISV = 0, ISS = 0x00000004
[183047.648100]   CM = 0, WnR = 0
[183047.651145] user pgtable: 4k pages, 48-bit VAs, pgdp =
00000000b7df67be
[183047.657834] [0000000000000058] pgd=0000000000000000
[183047.662789] Internal error: Oops: 96000004 [#1] SMP
[183047.667740] Process kworker/u16:2 (pid: 31291, stack limit =
0x00000000417c4974)
[183047.675208] CPU: 0 PID: 3291 Comm: kworker/u16:2 Tainted: G
W  OE 4.19.36-vhulk1907.1.0.h410.eulerosv2r8.aarch64 #1
[183047.687015] Hardware name: N/A N/A/Kunpeng Desktop Board D920S10,
BIOS 0.15 10/22/2019
[183047.695007] Workqueue: 0000:74:02.0_disco_q sas_discover_domain
[183047.700999] pstate: 20c00009 (nzCv daif +PAN +UAO)
[183047.705864] pc : prep_ata_v3_hw+0xf8/0x230 [hisi_sas_v3_hw]
[183047.711510] lr : prep_ata_v3_hw+0xb0/0x230 [hisi_sas_v3_hw]
[183047.717153] sp : ffff00000f28ba60
[183047.720541] x29: ffff00000f28ba60 x28: ffff8026852d7228
[183047.725925] x27: ffff8027dba3e0a8 x26: ffff8027c05fc200
[183047.731310] x25: 0000000000000000 x24: ffff8026bafa8dc0
[183047.736695] x23: ffff8027c05fc218 x22: ffff8026852d7228
[183047.742079] x21: ffff80007c2f2940 x20: ffff8027c05fc200
[183047.747464] x19: 0000000000f80800 x18: 0000000000000010
[183047.752848] x17: 0000000000000000 x16: 0000000000000000
[183047.758232] x15: ffff000089a5a4ff x14: 0000000000000005
[183047.763617] x13: ffff000009a5a50e x12: ffff8026bafa1e20
[183047.769001] x11: ffff0000087453b8 x10: ffff00000f28b870
[183047.774385] x9 : 0000000000000000 x8 : ffff80007e58f9b0
[183047.779770] x7 : 0000000000000000 x6 : 000000000000003f
[183047.785154] x5 : 0000000000000040 x4 : ffffffffffffffe0
[183047.790538] x3 : 00000000000000f8 x2 : 0000000002000007
[183047.795922] x1 : 0000000000000008 x0 : 0000000000000000
[183047.801307] Call trace:
[183047.803827]  prep_ata_v3_hw+0xf8/0x230 [hisi_sas_v3_hw]
[183047.809127]  hisi_sas_task_prep+0x750/0x888 [hisi_sas_main]
[183047.814773]  hisi_sas_task_exec.isra.7+0x88/0x1f0 [hisi_sas_main]
[183047.820939]  hisi_sas_queue_command+0x28/0x38 [hisi_sas_main]
[183047.826757]  smp_execute_task_sg+0xec/0x218
[183047.831013]  smp_execute_task+0x74/0xa0
[183047.834921]  sas_discover_expander.part.7+0x9c/0x5f8
[183047.839959]  sas_discover_root_expander+0x90/0x160
[183047.844822]  sas_discover_domain+0x1b8/0x1e8
[183047.849164]  process_one_work+0x1b4/0x3f8
[183047.853246]  worker_thread+0x54/0x470
[183047.856981]  kthread+0x134/0x138
[183047.860283]  ret_from_fork+0x10/0x18
[183047.863931] Code: f9407a80 528000e2 39409281 72a04002 (b9405800)
[183047.870097] kernel fault(0x1) notification starting on CPU 0
[183047.875828] kernel fault(0x1) notification finished on CPU 0
[183047.881559] Modules linked in: unibsp(OE) hns3(OE) hclge(OE)
hnae3(OE) mem_drv(OE) hisi_sas_v3_hw(OE) hisi_sas_main(OE)
[183047.892418] ---[ end trace 4cc26083fc11b783  ]---
[183047.897107] Kernel panic - not syncing: Fatal exception
[183047.902403] kernel fault(0x5) notification starting on CPU 0
[183047.908134] kernel fault(0x5) notification finished on CPU 0
[183047.913865] SMP: stopping secondary CPUs
[183047.917861] Kernel Offset: disabled
[183047.921422] CPU features: 0x2,a2a00a38
[183047.925243] Memory Limit: none
[183047.928372] kernel reboot(0x2) notification starting on CPU 0
[183047.934190] kernel reboot(0x2) notification finished on CPU 0
[183047.940008] ---[ end Kernel panic - not syncing: Fatal exception
]---

Fixes: 2908d778ab3e ("[SCSI] aic94xx: new driver")
Reported-by: Gao Chuan <gaochuan4@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/scsi/libsas/sas_discover.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/libsas/sas_discover.c b/drivers/scsi/libsas/sas_discover.c
index f47b4b281b14..23fdbc8fa05a 100644
--- a/drivers/scsi/libsas/sas_discover.c
+++ b/drivers/scsi/libsas/sas_discover.c
@@ -81,12 +81,18 @@ static int sas_get_port_device(struct asd_sas_port *port)
 		else
 			dev->dev_type = SAS_SATA_DEV;
 		dev->tproto = SAS_PROTOCOL_SATA;
-	} else {
+	} else if (port->oob_mode == SAS_OOB_MODE) {
 		struct sas_identify_frame *id =
 			(struct sas_identify_frame *) dev->frame_rcvd;
 		dev->dev_type = id->dev_type;
 		dev->iproto = id->initiator_bits;
 		dev->tproto = id->target_bits;
+	} else {
+		/* If the oob mode is OOB_NOT_CONNECTED, the port is
+		 * disconnected due to race with PHY down. We cannot
+		 * continue to discover this port */
+		sas_put_device(dev);
+		return rc;
 	}
 
 	sas_init_dev(dev);
-- 
2.17.2


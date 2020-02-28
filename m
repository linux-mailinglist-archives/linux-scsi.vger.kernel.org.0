Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42FCF17362B
	for <lists+linux-scsi@lfdr.de>; Fri, 28 Feb 2020 12:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgB1LjG (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 28 Feb 2020 06:39:06 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:44638 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726451AbgB1LjF (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 28 Feb 2020 06:39:05 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 11420E61C5EEB366BDFB;
        Fri, 28 Feb 2020 19:38:46 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Fri, 28 Feb 2020 19:38:36 +0800
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <takondra@cisco.com>,
        <tj@kernel.org>, "John Garry" <john.garry@huawei.com>
Subject: [PATCH] libata: Remove extra scsi_host_put() in ata_scsi_add_hosts()
Date:   Fri, 28 Feb 2020 19:33:35 +0800
Message-ID: <1582889615-146214-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

If the call to scsi_add_host_with_dma() in ata_scsi_add_hosts() fails,
then we may get use-after-free KASAN warns:

==================================================================
BUG: KASAN: use-after-free in kobject_put+0x24/0x180
Read of size 1 at addr ffff0026b8c80364 by task swapper/0/1
CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W         5.6.0-rc3-00004-g5a71b206ea82-dirty #1765
Hardware name: Huawei TaiShan 200 (Model 2280)/BC82AMDD, BIOS 2280-V2 CS V3.B160.01 02/24/2020
Call trace:
dump_backtrace+0x0/0x298
show_stack+0x14/0x20
dump_stack+0x118/0x190
print_address_description.isra.9+0x6c/0x3b8
__kasan_report+0x134/0x23c
kasan_report+0xc/0x18
__asan_load1+0x5c/0x68
kobject_put+0x24/0x180
put_device+0x10/0x20
scsi_host_put+0x10/0x18
ata_devres_release+0x74/0xb0
release_nodes+0x2d0/0x470
devres_release_all+0x50/0x78
really_probe+0x2d4/0x560
driver_probe_device+0x7c/0x148
device_driver_attach+0x94/0xa0
__driver_attach+0xa8/0x110
bus_for_each_dev+0xe8/0x158
driver_attach+0x30/0x40
bus_add_driver+0x220/0x2e0
driver_register+0xbc/0x1d0
__pci_register_driver+0xbc/0xd0
ahci_pci_driver_init+0x20/0x28
do_one_initcall+0xf0/0x608
kernel_init_freeable+0x31c/0x384
kernel_init+0x10/0x118
ret_from_fork+0x10/0x18

Allocated by task 5:
save_stack+0x28/0xc8
__kasan_kmalloc.isra.8+0xbc/0xd8
kasan_kmalloc+0xc/0x18
__kmalloc+0x1a8/0x280
scsi_host_alloc+0x44/0x678
ata_scsi_add_hosts+0x74/0x268
ata_host_register+0x228/0x488
ahci_host_activate+0x1c4/0x2a8
ahci_init_one+0xd18/0x1298
local_pci_probe+0x74/0xf0
work_for_cpu_fn+0x2c/0x48
process_one_work+0x488/0xc08
worker_thread+0x330/0x5d0
kthread+0x1c8/0x1d0
ret_from_fork+0x10/0x18

Freed by task 5:
save_stack+0x28/0xc8
__kasan_slab_free+0x118/0x180
kasan_slab_free+0x10/0x18
slab_free_freelist_hook+0xa4/0x1a0
kfree+0xd4/0x3a0
scsi_host_dev_release+0x100/0x148
device_release+0x7c/0xe0
kobject_put+0xb0/0x180
put_device+0x10/0x20
scsi_host_put+0x10/0x18
ata_scsi_add_hosts+0x210/0x268
ata_host_register+0x228/0x488
ahci_host_activate+0x1c4/0x2a8
ahci_init_one+0xd18/0x1298
local_pci_probe+0x74/0xf0
work_for_cpu_fn+0x2c/0x48
process_one_work+0x488/0xc08
worker_thread+0x330/0x5d0
kthread+0x1c8/0x1d0
ret_from_fork+0x10/0x18

There is also refcount issue, as well:
WARNING: CPU: 1 PID: 1 at lib/refcount.c:28 refcount_warn_saturate+0xf8/0x170

The issue is that we make an erroneous extra call to scsi_host_put()
for that host:

So in ahci_init_one()->ata_host_alloc_pinfo()->ata_host_alloc(), we setup
a device release method - ata_devres_release() - which intends to release
the SCSI hosts:

static void ata_devres_release(struct device *gendev, void *res)
{
	...
	for (i = 0; i < host->n_ports; i++) {
		struct ata_port *ap = host->ports[i];

		if (!ap)
			continue;

		if (ap->scsi_host)
			scsi_host_put(ap->scsi_host);

	}
	...
}

However in the ata_scsi_add_hosts() error path, we also call
scsi_host_put() for the SCSI hosts.

Fix by removing the the scsi_host_put() calls in ata_scsi_add_hosts() and
leave this to ata_devres_release().

Fixes: f31871951b38 ("libata: separate out ata_host_alloc() and ata_host_register()")
Signed-off-by: John Garry <john.garry@huawei.com>
---
Another approach here is to keep the scsi_host_put() call in
ata_scsi_add_hosts(), but just clear ap->scsi_host there. It may be
better, as it keeps the alloc and put together, which is more logical.

I went with this one as it removes code, instead of adding it, above. And
it also ensures we have a single location for the scsi_host_put() for
ap->host set.

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index eb2eb599e602..061eebf85e6d 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -4562,22 +4562,19 @@ int ata_scsi_add_hosts(struct ata_host *host, struct scsi_host_template *sht)
 		 */
 		shost->max_host_blocked = 1;
 
-		rc = scsi_add_host_with_dma(ap->scsi_host,
-						&ap->tdev, ap->host->dev);
+		rc = scsi_add_host_with_dma(shost, &ap->tdev, ap->host->dev);
 		if (rc)
-			goto err_add;
+			goto err_alloc;
 	}
 
 	return 0;
 
- err_add:
-	scsi_host_put(host->ports[i]->scsi_host);
  err_alloc:
 	while (--i >= 0) {
 		struct Scsi_Host *shost = host->ports[i]->scsi_host;
 
+		/* scsi_host_put() is in ata_devres_release() */
 		scsi_remove_host(shost);
-		scsi_host_put(shost);
 	}
 	return rc;
 }
-- 
2.17.1


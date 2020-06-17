Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9D031FC8DD
	for <lists+linux-scsi@lfdr.de>; Wed, 17 Jun 2020 10:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgFQIf4 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 17 Jun 2020 04:35:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:52108 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726519AbgFQIfz (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 17 Jun 2020 04:35:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A5381AC46;
        Wed, 17 Jun 2020 08:35:57 +0000 (UTC)
From:   mwilck@suse.com
To:     Don Brace <don.brace@microsemi.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     esc.storagedev@microsemi.com, linux-scsi@vger.kernel.org,
        shane.seymour@hpe.com, Martin Wilck <mwilck@suse.com>
Subject: [PATCH v2 3/3] scsi: smartpqi: remove conditional before pqi_remove_device()
Date:   Wed, 17 Jun 2020 10:35:14 +0200
Message-Id: <20200617083514.19174-4-mwilck@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200617083514.19174-1-mwilck@suse.com>
References: <20200617083514.19174-1-mwilck@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Martin Wilck <mwilck@suse.com>

pqi_remove_device() checks if there's anything to remove, for both
logical and SAS devices. So these conditionals are redundant.
They may actually be wrong, because they would skip removing pysical
devices which are not SMP expanders.

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 drivers/scsi/smartpqi/smartpqi_init.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index 87089b67ff74..7e4d5c5ea2b0 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -1879,8 +1879,7 @@ static void pqi_update_device_list(struct pqi_ctrl_info *ctrl_info,
 		} else {
 			pqi_dev_info(ctrl_info, "removed", device);
 		}
-		if (pqi_is_device_added(device))
-			pqi_remove_device(ctrl_info, device);
+		pqi_remove_device(ctrl_info, device);
 		list_del(&device->delete_list_entry);
 		pqi_free_device(device);
 	}
@@ -2223,8 +2222,7 @@ static void pqi_remove_all_scsi_devices(struct pqi_ctrl_info *ctrl_info)
 		if (!device)
 			break;
 
-		if (pqi_is_device_added(device))
-			pqi_remove_device(ctrl_info, device);
+		pqi_remove_device(ctrl_info, device);
 		pqi_free_device(device);
 	}
 }
-- 
2.26.2


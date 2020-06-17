Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF851FC8DC
	for <lists+linux-scsi@lfdr.de>; Wed, 17 Jun 2020 10:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgFQIf4 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 17 Jun 2020 04:35:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:52104 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726868AbgFQIfz (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 17 Jun 2020 04:35:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 89269AE0E;
        Wed, 17 Jun 2020 08:35:57 +0000 (UTC)
From:   mwilck@suse.com
To:     Don Brace <don.brace@microsemi.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     esc.storagedev@microsemi.com, linux-scsi@vger.kernel.org,
        shane.seymour@hpe.com, Martin Wilck <mwilck@suse.com>
Subject: [PATCH v2 2/3] scsi: smartpqi: check sdev in pqi_scsi_find_entry
Date:   Wed, 17 Jun 2020 10:35:13 +0200
Message-Id: <20200617083514.19174-3-mwilck@suse.com>
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

If a scsi device has been destroyed e.g. using the sysfs "delete"
attribute, subsequent host rescans won't re-discover it. This
patch makes it work at least via the smartqpi-specific "rescan"
sysfs attribute.

Reviewed-by: Shane Seymour <shane.seymour@hpe.com>
Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 drivers/scsi/smartpqi/smartpqi_init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index 54a72f465f85..87089b67ff74 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -1612,7 +1612,8 @@ static enum pqi_find_result pqi_scsi_find_entry(struct pqi_ctrl_info *ctrl_info,
 			device->scsi3addr)) {
 			*matching_device = device;
 			if (pqi_device_equal(device_to_find, device)) {
-				if (device_to_find->volume_offline)
+				if (device_to_find->volume_offline ||
+				    !pqi_get_scsi_device(device))
 					return DEVICE_CHANGED;
 				return DEVICE_SAME;
 			}
-- 
2.26.2


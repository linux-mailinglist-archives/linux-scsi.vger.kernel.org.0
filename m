Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC8A2E1C9
	for <lists+linux-scsi@lfdr.de>; Wed, 29 May 2019 18:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbfE2QAq (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 12:00:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56574 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbfE2QAq (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 29 May 2019 12:00:46 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1DF0030A6960;
        Wed, 29 May 2019 16:00:46 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.43.2.180])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4B56E4A2;
        Wed, 29 May 2019 16:00:44 +0000 (UTC)
From:   Tomas Henzl <thenzl@redhat.com>
To:     linux-scsi@vger.kernel.org
Cc:     sumit.saxena@broadcom.com, shivasharan.srikanteshwara@broadcom.com
Subject: [PATCH 1/3] megaraid_sas: make max_sectors visible in sys
Date:   Wed, 29 May 2019 18:00:39 +0200
Message-Id: <20190529160041.7242-2-thenzl@redhat.com>
In-Reply-To: <20190529160041.7242-1-thenzl@redhat.com>
References: <20190529160041.7242-1-thenzl@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 29 May 2019 16:00:46 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Support is easier with all driver parameters visible in sysfs.

Signed-off-by: Tomas Henzl <thenzl@redhat.com>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 3a9128ed3..3752daab0 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -64,7 +64,7 @@
  * Will be set in megasas_init_mfi if user does not provide
  */
 static unsigned int max_sectors;
-module_param_named(max_sectors, max_sectors, int, 0);
+module_param_named(max_sectors, max_sectors, int, S_IRUGO);
 MODULE_PARM_DESC(max_sectors,
 	"Maximum number of sectors per IO command");
 
-- 
2.20.1


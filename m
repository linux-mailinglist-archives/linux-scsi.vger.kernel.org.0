Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6261BD891
	for <lists+linux-scsi@lfdr.de>; Wed, 29 Apr 2020 11:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgD2Jpa (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 Apr 2020 05:45:30 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:39838 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726493AbgD2Jpa (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 29 Apr 2020 05:45:30 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 8594B4C851;
        Wed, 29 Apr 2020 09:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1588153526; x=1589967927; bh=V3oqHuU1e2QTNWK3tnj4jIdgLHH8krjIiqR
        uiY2SKKc=; b=LQmFiqUVjp1i+ndWfv7/YAjP+bcTwKHFTC6OS60GARblSr90dFZ
        xit9VQKLedENEfDW2N/wIVYQSiLgMrZPaXkQdPTt4kx9sRmZTbZ3ISA4oNg03ZBM
        gG1VUU3R46dzhg60zKUbA/RucHGSSIQfWA/TxEs3Et5AOyHdJl3HTpxU=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xPzoVa3QKF4F; Wed, 29 Apr 2020 12:45:26 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id EB9EF4C84D;
        Wed, 29 Apr 2020 12:45:25 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Wed, 29
 Apr 2020 12:45:27 +0300
From:   Roman Bolshakov <r.bolshakov@yadro.com>
To:     <target-devel@vger.kernel.org>,
        Mike Christie <mchristi@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        David Disseldorp <ddiss@suse.de>
CC:     <linux-scsi@vger.kernel.org>, <linux@yadro.com>,
        Roman Bolshakov <r.bolshakov@yadro.com>
Subject: [RFC PATCH 03/11] scsi: target/core: Add cleanup sequence in core_tpg_register()
Date:   Wed, 29 Apr 2020 12:44:36 +0300
Message-ID: <20200429094443.43937-4-r.bolshakov@yadro.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200429094443.43937-1-r.bolshakov@yadro.com>
References: <20200429094443.43937-1-r.bolshakov@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

It does not change any functionality but allows to introduce more steps
in the cleanup sequence without code duplication later.

Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
---
 drivers/target/target_core_tpg.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/target/target_core_tpg.c b/drivers/target/target_core_tpg.c
index d24e0a3ba3ff..d3896c3f2f95 100644
--- a/drivers/target/target_core_tpg.c
+++ b/drivers/target/target_core_tpg.c
@@ -484,10 +484,8 @@ int core_tpg_register(
 
 		ret = core_tpg_add_lun(se_tpg, se_tpg->tpg_virt_lun0,
 				true, g_lun0_dev);
-		if (ret < 0) {
-			kfree(se_tpg->tpg_virt_lun0);
-			return ret;
-		}
+		if (ret < 0)
+			goto out_free_lun0;
 	}
 
 	pr_debug("TARGET_CORE[%s]: Allocated portal_group for endpoint: %s, "
@@ -497,6 +495,10 @@ int core_tpg_register(
 		se_tpg->proto_id, se_tpg->se_tpg_tfo->tpg_get_tag(se_tpg));
 
 	return 0;
+
+out_free_lun0:
+	kfree(se_tpg->tpg_virt_lun0);
+	return ret;
 }
 EXPORT_SYMBOL(core_tpg_register);
 
-- 
2.26.1


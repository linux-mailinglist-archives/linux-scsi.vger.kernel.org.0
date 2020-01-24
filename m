Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAC314785D
	for <lists+linux-scsi@lfdr.de>; Fri, 24 Jan 2020 06:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730602AbgAXF40 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 24 Jan 2020 00:56:26 -0500
Received: from relay.sw.ru ([185.231.240.75]:51168 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727250AbgAXF40 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 24 Jan 2020 00:56:26 -0500
Received: from vvs-ws.sw.ru ([172.16.24.21])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <vvs@virtuozzo.com>)
        id 1iurxA-0007jZ-30; Fri, 24 Jan 2020 08:56:24 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH 1/1] snic_trc_seq_next should increase position index
To:     linux-scsi@vger.kernel.org
Cc:     Karan Tilak Kumar <kartilak@cisco.com>,
        Sesidhar Baddela <sebaddel@cisco.com>
Message-ID: <0617d789-fea3-53ae-cd19-78894d6bbd81@virtuozzo.com>
Date:   Fri, 24 Jan 2020 08:56:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

if seq_file .next fuction does not change position index,
read after some lseek can generate unexpected output.

https://bugzilla.kernel.org/show_bug.cgi?id=206283
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 drivers/scsi/snic/snic_debugfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/snic/snic_debugfs.c b/drivers/scsi/snic/snic_debugfs.c
index 2b34936..b20c724 100644
--- a/drivers/scsi/snic/snic_debugfs.c
+++ b/drivers/scsi/snic/snic_debugfs.c
@@ -419,6 +419,7 @@ void snic_stats_debugfs_init(struct snic *snic)
 static void *
 snic_trc_seq_next(struct seq_file *sfp, void *data, loff_t *pos)
 {
+	(*pos)++;
 	return NULL;
 }
 
-- 
1.8.3.1


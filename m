Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF8BD16C4
	for <lists+linux-scsi@lfdr.de>; Wed,  9 Oct 2019 19:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732011AbfJIRX5 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 9 Oct 2019 13:23:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:48034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731991AbfJIRX4 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 9 Oct 2019 13:23:56 -0400
Received: from sasha-vm.mshome.net (unknown [167.220.2.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4890C2196E;
        Wed,  9 Oct 2019 17:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570641835;
        bh=mqorUQN+cdr1Eu4q/RLzx0/E236qnHRyOfcEwcMOZpw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GvKxjycxuerqhaoq03DkHst1b2I2cDVYLhY/VNCuVUB3DNIJADBn1UjAV5aFhIKcX
         eaOqQGxNio+g9yN4RVyah+6LbV6ErI2S/zPMYdBrpcTZf2+4IXcYjqep4Av4lu1PEc
         4S+ZJwhvoWcOpC/1JreNpwf/jVZpeMB/ivxsTcKk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stanley Chu <stanley.chu@mediatek.com>,
        Bean Huo <beanhuo@micron.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.3 07/68] scsi: ufs: skip shutdown if hba is not powered
Date:   Wed,  9 Oct 2019 13:04:46 -0400
Message-Id: <20191009170547.32204-7-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191009170547.32204-1-sashal@kernel.org>
References: <20191009170547.32204-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Stanley Chu <stanley.chu@mediatek.com>

[ Upstream commit f51913eef23f74c3bd07899dc7f1ed6df9e521d8 ]

In some cases, hba may go through shutdown flow without successful
initialization and then make system hang.

For example, if ufshcd_change_power_mode() gets error and leads to
ufshcd_hba_exit() to release resources of the host, future shutdown flow
may hang the system since the host register will be accessed in unpowered
state.

To solve this issue, simply add checking to skip shutdown for above kind of
situation.

Link: https://lore.kernel.org/r/1568780438-28753-1-git-send-email-stanley.chu@mediatek.com
Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
Acked-by: Bean Huo <beanhuo@micron.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/ufs/ufshcd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 029da74bb2f5c..e674f6148f698 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -8095,6 +8095,9 @@ int ufshcd_shutdown(struct ufs_hba *hba)
 {
 	int ret = 0;
 
+	if (!hba->is_powered)
+		goto out;
+
 	if (ufshcd_is_ufs_dev_poweroff(hba) && ufshcd_is_link_off(hba))
 		goto out;
 
-- 
2.20.1


Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E484127D44
	for <lists+linux-scsi@lfdr.de>; Fri, 20 Dec 2019 15:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbfLTOam (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 20 Dec 2019 09:30:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:34362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727806AbfLTOaj (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 20 Dec 2019 09:30:39 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 201F324688;
        Fri, 20 Dec 2019 14:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576852238;
        bh=kn1yMQ++v+tSgPYIXSWQshWLlh0px6/1OR/qxa63mqs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dRQ/rL1hBIdxFHzaj8Df2eZdHvalLVmb8iihpj6zXMaYbhhWXxANpREbmbg1BFXnp
         n1E3L+u6QOwiHzvWv+RG50N9b1/C6yFUX/Q7dpZlknpyCkBLwIQpcoQ3wHKJFAw3Ag
         NxXZJlsV5Laskx0Os7bNykmw83nF7K4dm9yw6VOA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 32/52] scsi: iscsi: qla4xxx: fix double free in probe
Date:   Fri, 20 Dec 2019 09:29:34 -0500
Message-Id: <20191220142954.9500-32-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220142954.9500-1-sashal@kernel.org>
References: <20191220142954.9500-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit fee92f25777789d73e1936b91472e9c4644457c8 ]

On this error path we call qla4xxx_mem_free() and then the caller also
calls qla4xxx_free_adapter() which calls qla4xxx_mem_free().  It leads to a
couple double frees:

drivers/scsi/qla4xxx/ql4_os.c:8856 qla4xxx_probe_adapter() warn: 'ha->chap_dma_pool' double freed
drivers/scsi/qla4xxx/ql4_os.c:8856 qla4xxx_probe_adapter() warn: 'ha->fw_ddb_dma_pool' double freed

Fixes: afaf5a2d341d ("[SCSI] Initial Commit of qla4xxx")
Link: https://lore.kernel.org/r/20191203094421.hw7ex7qr3j2rbsmx@kili.mountain
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla4xxx/ql4_os.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
index 8c674eca09f13..2323432a0edbc 100644
--- a/drivers/scsi/qla4xxx/ql4_os.c
+++ b/drivers/scsi/qla4xxx/ql4_os.c
@@ -4275,7 +4275,6 @@ static int qla4xxx_mem_alloc(struct scsi_qla_host *ha)
 	return QLA_SUCCESS;
 
 mem_alloc_error_exit:
-	qla4xxx_mem_free(ha);
 	return QLA_ERROR;
 }
 
-- 
2.20.1


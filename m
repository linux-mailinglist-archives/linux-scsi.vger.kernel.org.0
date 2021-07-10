Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFE43C2D00
	for <lists+linux-scsi@lfdr.de>; Sat, 10 Jul 2021 04:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbhGJCVX (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 9 Jul 2021 22:21:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:37728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232235AbhGJCVR (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 9 Jul 2021 22:21:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 72E47613D0;
        Sat, 10 Jul 2021 02:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625883513;
        bh=1m5z75DwI4RoLI8EnXWRT11op3skV4v8WeTYrrnBb04=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TW88wyBEGUEXcoUY7welB4ZaXEFz2qGpJ/MMOF41QnlGgC1r7o+nq46cTuLxh70qM
         qlsVlvLSsgaG2uR5g1xW61D8oemHy+qI+blYlH1ONcLxUJA6PuLhQKBiLTTf39DlKG
         REkZin30Jd1i26q69KtsMQ5cGdNa2/SzPLpzwtXIt7jRr6666UwRPmNrsGpFE7oXqx
         yVWzD7NGCApNr7nTEKjFMiEsc6vSm1UtbYNA+AwNRdHYrhFAOPWTxHqTQpF9TfeTNo
         MRKsgxPNpxJx2LKaHEuLa/oGfkUT8ZS6qRVxycAurO4EtiRMm6ALW9JGrhKlre/Qyk
         yM0PBZlLZ5DXw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     John Garry <john.garry@huawei.com>, Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.13 032/114] scsi: core: Cap scsi_host cmd_per_lun at can_queue
Date:   Fri,  9 Jul 2021 22:16:26 -0400
Message-Id: <20210710021748.3167666-32-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210710021748.3167666-1-sashal@kernel.org>
References: <20210710021748.3167666-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: John Garry <john.garry@huawei.com>

[ Upstream commit ea2f0f77538c50739b9fb4de4700cee5535e1f77 ]

The sysfs handling function sdev_store_queue_depth() enforces that the sdev
queue depth cannot exceed shost can_queue. The initial sdev queue depth
comes from shost cmd_per_lun. However, the LLDD may manually set
cmd_per_lun to be larger than can_queue, which leads to an initial sdev
queue depth greater than can_queue.

Such an issue was reported in [0], which caused a hang. That has since been
fixed in commit fc09acb7de31 ("scsi: scsi_debug: Fix cmd_per_lun, set to
max_queue").

Stop this possibly happening for other drivers by capping shost cmd_per_lun
at shost can_queue.

[0] https://lore.kernel.org/linux-scsi/YHaez6iN2HHYxYOh@T590/

Link: https://lore.kernel.org/r/1621434662-173079-1-git-send-email-john.garry@huawei.com
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: John Garry <john.garry@huawei.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/hosts.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index cd52664920e1..2684be9a79a8 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -220,6 +220,9 @@ int scsi_add_host_with_dma(struct Scsi_Host *shost, struct device *dev,
 		goto fail;
 	}
 
+	shost->cmd_per_lun = min_t(short, shost->cmd_per_lun,
+				   shost->can_queue);
+
 	error = scsi_init_sense_cache(shost);
 	if (error)
 		goto fail;
-- 
2.30.2


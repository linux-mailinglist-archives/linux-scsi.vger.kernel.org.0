Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B491FDF07
	for <lists+linux-scsi@lfdr.de>; Thu, 18 Jun 2020 03:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731635AbgFRBiP (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 17 Jun 2020 21:38:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:40502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731811AbgFRBae (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 17 Jun 2020 21:30:34 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21E6621D90;
        Thu, 18 Jun 2020 01:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443833;
        bh=ttn8Ozt/ANtbplld6OHlA8lbucWzZr1/YkK0kMkRdas=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=avHwUyKgwM0X8EMfoyj6oUGWuIVx4ACm54SUj7bhfH93Vo6cC1MoWirNUJhxJaIq3
         JcOOOO6G1+4N8JdUDZlf2s71ZG7oDdBjIon3RGjpZr65q+m6cB1VwUhf/i/Neesj0D
         EDmPebt1Z0RpCniBo/nUxSsZcvAVOSbA4QATn5HU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tyrel Datwyler <tyreld@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.4 21/60] scsi: ibmvscsi: Don't send host info in adapter info MAD after LPM
Date:   Wed, 17 Jun 2020 21:29:25 -0400
Message-Id: <20200618013004.610532-21-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618013004.610532-1-sashal@kernel.org>
References: <20200618013004.610532-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Tyrel Datwyler <tyreld@linux.ibm.com>

[ Upstream commit 4919b33b63c8b69d8dcf2b867431d0e3b6dc6d28 ]

The adapter info MAD is used to send the client info and receive the host
info as a response. A persistent buffer is used and as such the client info
is overwritten after the response. During the course of a normal adapter
reset the client info is refreshed in the buffer in preparation for sending
the adapter info MAD.

However, in the special case of LPM where we reenable the CRQ instead of a
full CRQ teardown and reset we fail to refresh the client info in the
adapter info buffer. As a result, after Live Partition Migration (LPM) we
erroneously report the host's info as our own.

[mkp: typos]

Link: https://lore.kernel.org/r/20200603203632.18426-1-tyreld@linux.ibm.com
Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/ibmvscsi/ibmvscsi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/ibmvscsi/ibmvscsi.c b/drivers/scsi/ibmvscsi/ibmvscsi.c
index e26747a1b35a..e7075aae15da 100644
--- a/drivers/scsi/ibmvscsi/ibmvscsi.c
+++ b/drivers/scsi/ibmvscsi/ibmvscsi.c
@@ -427,6 +427,8 @@ static int ibmvscsi_reenable_crq_queue(struct crq_queue *queue,
 	int rc = 0;
 	struct vio_dev *vdev = to_vio_dev(hostdata->dev);
 
+	set_adapter_info(hostdata);
+
 	/* Re-enable the CRQ */
 	do {
 		if (rc)
-- 
2.25.1


Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D55B25F93A
	for <lists+linux-scsi@lfdr.de>; Thu,  4 Jul 2019 15:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbfGDNg0 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 4 Jul 2019 09:36:26 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43362 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbfGDNg0 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 4 Jul 2019 09:36:26 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hj1uS-00016i-RK; Thu, 04 Jul 2019 13:36:24 +0000
From:   Colin King <colin.king@canonical.com>
To:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: message: fusion: remove redundant assignment to variable ret
Date:   Thu,  4 Jul 2019 14:36:24 +0100
Message-Id: <20190704133624.31081-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable ret is being initialized with a value that is never
read and it is being updated later with a new value. The
initialization is redundant and can be removed.  Also move { brace
to the conventional coding style location.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/message/fusion/mptbase.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
index c2dd322691d1..449916e062ce 100644
--- a/drivers/message/fusion/mptbase.c
+++ b/drivers/message/fusion/mptbase.c
@@ -7106,8 +7106,9 @@ mpt_SoftResetHandler(MPT_ADAPTER *ioc, int sleepFlag)
  *	HardReset.
  **/
 int
-mpt_Soft_Hard_ResetHandler(MPT_ADAPTER *ioc, int sleepFlag) {
-	int ret = -1;
+mpt_Soft_Hard_ResetHandler(MPT_ADAPTER *ioc, int sleepFlag)
+{
+	int ret;
 
 	ret = mpt_SoftResetHandler(ioc, sleepFlag);
 	if (ret == 0)
-- 
2.20.1


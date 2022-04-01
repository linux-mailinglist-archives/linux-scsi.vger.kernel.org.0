Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7BE4EF307
	for <lists+linux-scsi@lfdr.de>; Fri,  1 Apr 2022 17:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbiDAPEL (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 1 Apr 2022 11:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349547AbiDAO4u (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 1 Apr 2022 10:56:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C559413E171;
        Fri,  1 Apr 2022 07:44:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C7A1B82500;
        Fri,  1 Apr 2022 14:44:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 706DEC3410F;
        Fri,  1 Apr 2022 14:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648824258;
        bh=Wk+6hcNnI+3SJsPfyQzilYKRECGWKUXVbLzm4EbJ+NU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mYq1ofgyUsLABh42yakIuMOJCVRACwMg1n8JrhQWPM2iDqscESFGog7cjGEvZvO1f
         +BWEDdrgdKjr+CYuFk0II12mykbjOHLXpKtzk++fbG+MJpp/vp3YK+WMPyFQKzWZi7
         LydI1d1DVLur1C51jlU8DiIqaMgaxObL4oGo5fG2L/41RHJUK0uG79bkh3iwWgBTpz
         NfN3oNzcivJxQc2R2BlCqDOP0gkDVDTsBKPQG8cWaM1F+bvsT+mWcIM8cdEgHOIW7e
         Ivuj253GXYPKGYyzA+2Yyi9dO/9FRjOarVPPsbRyJo0Q1h87b+BLTQtlDQz4UOARD6
         bJaqaYQxBo93A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jianglei Nie <niejianglei2021@163.com>,
        Hannes Reinecke <hare@suse.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, jejb@linux.ibm.com,
        linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 53/65] scsi: libfc: Fix use after free in fc_exch_abts_resp()
Date:   Fri,  1 Apr 2022 10:41:54 -0400
Message-Id: <20220401144206.1953700-53-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220401144206.1953700-1-sashal@kernel.org>
References: <20220401144206.1953700-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Jianglei Nie <niejianglei2021@163.com>

[ Upstream commit 271add11994ba1a334859069367e04d2be2ebdd4 ]

fc_exch_release(ep) will decrease the ep's reference count. When the
reference count reaches zero, it is freed. But ep is still used in the
following code, which will lead to a use after free.

Return after the fc_exch_release() call to avoid use after free.

Link: https://lore.kernel.org/r/20220303015115.459778-1-niejianglei2021@163.com
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/libfc/fc_exch.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/libfc/fc_exch.c b/drivers/scsi/libfc/fc_exch.c
index a50f1eef0e0c..4261380af97b 100644
--- a/drivers/scsi/libfc/fc_exch.c
+++ b/drivers/scsi/libfc/fc_exch.c
@@ -1702,6 +1702,7 @@ static void fc_exch_abts_resp(struct fc_exch *ep, struct fc_frame *fp)
 	if (cancel_delayed_work_sync(&ep->timeout_work)) {
 		FC_EXCH_DBG(ep, "Exchange timer canceled due to ABTS response\n");
 		fc_exch_release(ep);	/* release from pending timer hold */
+		return;
 	}
 
 	spin_lock_bh(&ep->ex_lock);
-- 
2.34.1


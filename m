Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A407A5951E5
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Aug 2022 07:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbiHPFTe (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 16 Aug 2022 01:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbiHPFTM (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 16 Aug 2022 01:19:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DEB1C21DD;
        Mon, 15 Aug 2022 14:42:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE500B811BF;
        Mon, 15 Aug 2022 21:42:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5988DC433D6;
        Mon, 15 Aug 2022 21:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660599763;
        bh=J5sILHxjfHL2mngdVIkP+62Tsl5BM29kcszjyaZgtTM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ULAZ4sTT/Mfp7G7ebqcnzGlna8miB9S2AwB9BgcbB/JuXmMpPr7cfPCQnwDw7PMuA
         ZMxWtTbU5TDApU6vqxIgSdapoRSZRIcgecgILwrVPGCAkSP9N1toRhWTlCYFgKOPkS
         PXHu0z/Dva+XPvwEZn1vPXAtSVwNwqblnfTnwMaxxARol7mpnKEVU47iU8tOvLWCkd
         YqzYylwjgZXD1z+VyG9KUSYPZm0S5hfvUo4UszZr+v5l+NbvwC5r/Qp9nQHAnMk4CL
         0JH4Jg6wuLFmPKnCphPsmLgXfp2n65rxQKEpr55wPUOPBWba5aFw+eTXMDjR88IElx
         ykiTveYvARyrQ==
Date:   Mon, 15 Aug 2022 16:42:21 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH v3 2/6] scsi: megaraid_sas: Replace one-element array with
 flexible-array member in MR_FW_RAID_MAP_DYNAMIC
Message-ID: <896476f8fe43cf83b491c6c13f59c9ace780d82c.1660592640.git.gustavoars@kernel.org>
References: <cover.1660592640.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1660592640.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

One-element arrays are deprecated, and we are replacing them with
flexible array members, instead. So, replace one-element array with
flexible-array member in struct MR_FW_RAID_MAP_DYNAMIC.

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
routines on memcpy().

Link: https://github.com/KSPP/linux/issues/79
Link: https://github.com/KSPP/linux/issues/109
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v3:
 - None.

Changes in v2:
 - None.

 drivers/scsi/megaraid/megaraid_sas_fusion.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.h b/drivers/scsi/megaraid/megaraid_sas_fusion.h
index 5530c233fccb..66e13b74fcdc 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.h
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.h
@@ -1053,7 +1053,7 @@ struct MR_FW_RAID_MAP_DYNAMIC {
 	struct MR_RAID_MAP_DESC_TABLE
 			raid_map_desc_table[RAID_MAP_DESC_TYPE_COUNT];
 	/* Variable Size buffer containing all data */
-	u32 raid_map_desc_data[1];
+	u32 raid_map_desc_data[];
 }; /* Dynamicaly sized RAID MAp structure */
 
 #define IEEE_SGE_FLAGS_ADDR_MASK            (0x03)
-- 
2.34.1


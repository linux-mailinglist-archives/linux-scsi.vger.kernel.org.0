Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23F66E4942
	for <lists+linux-scsi@lfdr.de>; Mon, 17 Apr 2023 15:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbjDQNEM (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 17 Apr 2023 09:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjDQNDq (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 17 Apr 2023 09:03:46 -0400
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E134E2694;
        Mon, 17 Apr 2023 06:00:48 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id DE7432B06736;
        Mon, 17 Apr 2023 08:59:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 17 Apr 2023 08:59:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1681736364; x=
        1681736964; bh=3MYpSnaVDohgO0A6g9VDdRLlAof0SUXov2aX/Aa7Rro=; b=r
        5bcdBLUG2dhF37VhsL2DQJv6sz4MvB1+sPPmIOmRJ8yEHEtTRg1Ew0nrFhoJt3ln
        S9oi0Aw8H1RVC789SGTl9M+VJaFLx8rSDdV6bb2nmWI8W/PeWaB60Wu9PIQJOjSo
        lhOtQhY88f3nYhBAZMW2XhSdV9Sg8eRErlNWeLDK4380dlAUJfr6Abaj2UjciL/3
        99Z/iL15I7pOksVs2bJdFrMQykG2bNTufAVQlETZCltl3FmNC4KdxFQUqa596B95
        RgZfhOWpMGedTUwCV3WBS6pwnBqBOuwYIThbdLCpoyohY44o1RJnbCqis5v07htc
        +REWLYbIC8MGg82S23VfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=ie1e949a3.fm3; t=
        1681736364; x=1681736964; bh=3MYpSnaVDohgO0A6g9VDdRLlAof0SUXov2a
        X/Aa7Rro=; b=E2cBV1XcVxeUqVtgh9cClxxpeonEfrQEUsBb6Tp+JL7rf31lNhv
        AJ0UXZoLu2iu0/dVfukKUMj2W/dm6SWuXdnbWTc8Mmnll4W6kOOk/aoQCv/d3C2w
        qKXxic43O7CBba4sruPl1JSVLNbt8jW4MABas6EhFN4oHBWSEJ05uoswny66hjbl
        xT9rkOonoPXXmIlTlLmpRZ5lXoImbCn9SOkH5JMSXUi7AacVKOFyTuZlxjLrEAIB
        eex0WSUxUpM+z4c3beA0kGmyp+F+K4E7+I3gO/BT2zuzj030BCF9FcmJupPm9EKH
        bbYlMOMzes4tvBeMivqh7ePa28xZGlmZJJw==
X-ME-Sender: <xms:rEI9ZC1nYQGoxjfawK__71c5jqqZV6UulZINyzY9Bh56A_sycyFQUg>
    <xme:rEI9ZFF4nYSelDmox4xqtfZX-61itrzkeMX4Q-W2epEyZ-tq1bpCFmLunggtomgIN
    t40vkh5jjjwgMU8gmI>
X-ME-Received: <xmr:rEI9ZK5YMRHAa7hjyWuwWDon23L_LQ_GsnKTYHT9JCEt9_-lrMKmDgWZtJ-QC0JinJTpK4kl0YjEiqHg3kF5ZYzlSsZYPuEsXdFcDaBm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeliedgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefuhhhinhdkihgthhhirhhoucfmrgifrghsrghkihcuoehs
    hhhinhhitghhihhrohesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpe
    fggfegffejgeefueetgeeukedvhfeludfhhefftdeitdfhteelieefiefhueekgeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehshhhinhhitg
    hhihhrohesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:rEI9ZD2C-pBpaQ6j5DAkezNXILFPHr4zfhGghUsXE0Y62Y7xIEOdpg>
    <xmx:rEI9ZFEGLP6L7Wj8wGBAod_3Dwwxb6M4DoOVKnXuUJO6arcW_tdOQw>
    <xmx:rEI9ZM8S_letwdFoHzmp9uw89pUVArXCDzAU8nNC6mr8uenj5nXAPw>
    <xmx:rEI9ZKQsGRFrmoJygoAEtoXLcsczIbngDXVIGPsMJZaJBlPVQnBKU7TaWW2rpc_c>
Feedback-ID: ie1e949a3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Apr 2023 08:59:22 -0400 (EDT)
From:   Shin'ichiro Kawasaki <shinichiro@fastmail.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 7/9] block/001: allow to run with built-in scsi_debug and sd_mod
Date:   Mon, 17 Apr 2023 21:59:11 +0900
Message-Id: <20230417125913.458726-3-shinichiro@fastmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230417125913.458726-1-shinichiro@fastmail.com>
References: <20230417125913.458726-1-shinichiro@fastmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

To allow the test case run with build-in scsi_debug, replace
'_have_module scsi_debug' with _have_scsi_debug, and replace
_init_scsi_debug with _configure_scsi_debug.

Also, to allow the test case run with build-in sd_mod, replace
'_have_module sd_mod' with '_have_kernel_option BLK_DEV_SD'. When sd_mod
driver is built-in, /sys/module/sd_mod directory is not created. Then
_have_driver() can not detect availability of the driver. Instead, refer
the kernel config to check availability of the driver.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/block/001 | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/block/001 b/tests/block/001
index 2ea3754..32dd22f 100755
--- a/tests/block/001
+++ b/tests/block/001
@@ -13,13 +13,13 @@ DESCRIPTION="stress device hotplugging"
 TIMED=1
 
 requires() {
-	_have_module scsi_debug
-	_have_driver sd_mod
+	_have_scsi_debug
+	_have_kernel_option BLK_DEV_SD
 	_have_driver sr_mod
 }
 
 stress_scsi_debug() {
-	if ! _init_scsi_debug "$@"; then
+	if ! _configure_scsi_debug "$@"; then
 		return
 	fi
 
-- 
2.39.2


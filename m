Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973C55A1BFA
	for <lists+linux-scsi@lfdr.de>; Fri, 26 Aug 2022 00:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244093AbiHYWMT (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 25 Aug 2022 18:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbiHYWMR (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 25 Aug 2022 18:12:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA696275C9
        for <linux-scsi@vger.kernel.org>; Thu, 25 Aug 2022 15:12:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96A95B82EA3
        for <linux-scsi@vger.kernel.org>; Thu, 25 Aug 2022 22:12:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 419EFC433B5
        for <linux-scsi@vger.kernel.org>; Thu, 25 Aug 2022 22:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661465534;
        bh=G7eKWIabxFqFSpdryFM4to4cVKqIHmS4DJQF3hTgZHg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=a9pyqCdSf2UTu+tArc9vEvAziiMR+SjAy0g+HfFtENue+//E4LLB10J+nvfU+nh70
         MbKUQ+C7wTGrLqOb0EEAPnd6lJdn+KR2C3k1OXvzFLIaSx5hDqElgEW8+kqMnM2n10
         y3HxMcjMmMPv0CN2hGWXrUmEP4ll8OvJNNayvLdqo0X9cS1z7kVPtz4kxolFkaLjSB
         eC6HGwVFBhmMIx0LNH6PtXOJCRY7T6F6R6svW+yyHPJ43GYfumCfkqW4DieA0YVOpN
         LVLuoJo0MtKvlvAs1spuL2uJOHkCWaALBih6ZW+dMVBtCH6j9hVWwgs2LPMyziHfgf
         aZiIBQ2NYmZJQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 2890FC433E9; Thu, 25 Aug 2022 22:12:14 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-scsi@vger.kernel.org
Subject: [Bug 216413] [BISECT INCLUDED] scsi/sd Rework asynchronous resume
 support breaks S2idle and S3 on several systems
Date:   Thu, 25 Aug 2022 22:12:13 +0000
X-Bugzilla-Reason: CC
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: IO/Storage
X-Bugzilla-Component: SCSI
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: todd.e.brandt@intel.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: bvanassche@acm.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216413-11613-IuVcKnxMS7@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216413-11613@https.bugzilla.kernel.org/>
References: <bug-216413-11613@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216413

--- Comment #8 from Todd Brandt (todd.e.brandt@intel.com) ---
(In reply to Bart Van Assche from comment #7)
> On 8/25/22 14:46, bugzilla-daemon@kernel.org wrote:
> > When will this make it upstream? In 6.0.0-rc3 hopefully?
>=20
> I'm not sure. This depends on the SCSI maintainer.

ok, thank you, I'll keep monitoring and will close this bug when it lands
upstream.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are on the CC list for the bug.=

Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4895A1B15
	for <lists+linux-scsi@lfdr.de>; Thu, 25 Aug 2022 23:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiHYVcV (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 25 Aug 2022 17:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243761AbiHYVcE (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 25 Aug 2022 17:32:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD70DA1D54
        for <linux-scsi@vger.kernel.org>; Thu, 25 Aug 2022 14:32:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A75F61B48
        for <linux-scsi@vger.kernel.org>; Thu, 25 Aug 2022 21:32:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B024FC433B5
        for <linux-scsi@vger.kernel.org>; Thu, 25 Aug 2022 21:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661463122;
        bh=zWsG0RnqwKkS7A7xM4VlDwjHBjCqZHH8gXevmv6a+m0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=H+Ouc6FTg98ySME8LUxoOhfaVFzLGpR1vkpRDPI7hQnlcS1GdYGugZeWid+dbyNyc
         bOyJOI+1B6azYxfkKEG53o68kbJ8ybgZVtwxES2r+4mtbfLrkqGAPKswxF/VEqIz3r
         7noRYXNjPOa9d9lI0TapNBP1odh83+P7rcn8GgZgbl6c1wsZpflGYb/HVE23Qb1Z8p
         yFuAkJ2yI5oNnFWHdxZWt2doTiAUEkF1zOvppU6a+6h1JtmVP9hISe91SQAWmwcmB/
         qbu3nJbyAJLx2yhkw/PIQMsxR+w/lOHeD6ok4gzhDWM/ep0/wHD6kkHbpJX/jBDYJk
         NEkUSb1uXs/gQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id A0FCDC433E4; Thu, 25 Aug 2022 21:32:02 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-scsi@vger.kernel.org
Subject: [Bug 216413] [BISECT INCLUDED] scsi/sd Rework asynchronous resume
 support breaks S2idle and S3 on several systems
Date:   Thu, 25 Aug 2022 21:32:02 +0000
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
Message-ID: <bug-216413-11613-wMkziMfWdf@https.bugzilla.kernel.org/>
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

--- Comment #3 from Todd Brandt (todd.e.brandt@intel.com) ---
One other thing to note, I tried removing this one commit from the very lat=
est
6.0.0-rc2 code upstream and it fixed it completely. So there's no doubt this
one commit is the sole cause of the hang.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are on the CC list for the bug.=

Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BADB746153
	for <lists+linux-scsi@lfdr.de>; Mon,  3 Jul 2023 19:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjGCRVJ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 3 Jul 2023 13:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjGCRVI (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 3 Jul 2023 13:21:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E18E6D
        for <linux-scsi@vger.kernel.org>; Mon,  3 Jul 2023 10:21:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF9B660FEF
        for <linux-scsi@vger.kernel.org>; Mon,  3 Jul 2023 17:21:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 224BFC433C9
        for <linux-scsi@vger.kernel.org>; Mon,  3 Jul 2023 17:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688404866;
        bh=AbyASj8VxRAKUk63DjrBZeuIm1L4874IV0kPw+on+rI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=gC/be0N/Ax67g+gY6ihmfk7OD/P0L1SFf77FoyHJ/wEuarV6HSBpP/jpS6Ci5rzy+
         pRuS5wQOjaW8UlkC8jwiWVKmo9SvygWS+4pd4do9LK/iVSqwY8g6JWNuVK35yZDqpm
         CpcOmhxOtPRd/Ut10anDUx6EB7QfRvv3KkLbl4H3k+5tjCk/hgy/Q9hsgBcY9+nhVF
         NTMVtY5Nwl+TKXR8qCwvozpyb+6PDi+zAQgOc9wGNVC4sEJ6QboXNoTdwpicyuxNoi
         6BV0TJpeb6QUL3s820WY6rP+iDHTAarBUIsIBLpS4TSjc6nDUM9LYmnGdHD+eBRH5m
         IpO2MYjsVk5qg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 0985BC53BD2; Mon,  3 Jul 2023 17:21:06 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-scsi@vger.kernel.org
Subject: [Bug 217599] Adaptec 71605z hangs with aacraid: Host adapter abort
 request after update to linux 6.4.0
Date:   Mon, 03 Jul 2023 17:21:05 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo scsi_drivers-aacraid@kernel-bugs.osdl.org
X-Bugzilla-Product: SCSI Drivers
X-Bugzilla-Component: AACRAID
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: pheidologeton@protonmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: scsi_drivers-aacraid@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217599-11613-NPmXyPt1xJ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217599-11613@https.bugzilla.kernel.org/>
References: <bug-217599-11613@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217599

--- Comment #6 from pheidologeton@protonmail.com ---
An interesting observation. After changing the i/o scheduler to none,
controller hangs started to happen much less often. At the moment kernel 6.=
4.1

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

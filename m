Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1B35A1B0F
	for <lists+linux-scsi@lfdr.de>; Thu, 25 Aug 2022 23:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbiHYVbC (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 25 Aug 2022 17:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbiHYVbA (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 25 Aug 2022 17:31:00 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291C4BB035
        for <linux-scsi@vger.kernel.org>; Thu, 25 Aug 2022 14:30:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 85874CE29C1
        for <linux-scsi@vger.kernel.org>; Thu, 25 Aug 2022 21:30:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C85C9C43470
        for <linux-scsi@vger.kernel.org>; Thu, 25 Aug 2022 21:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661463055;
        bh=RO8wb5nujwhPwrFI+Qbz23d1UTl8OOrJe2I0fObTC58=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=p0eruGYdrPZ3PBeIZOQIOOQ/u29c7PXo7OsFwNyDyvZlrsNS8v2ofSYl+P3unMu2n
         EoHO7VRjUZ2vsdSOWRXhF2tztBvZfKZWV/fzhEkKVWvvFnRDVsYL7ihCy43e9nR/Ib
         oKlzMi4Nss/U40fMRQWFBkRhvS3cWoXssfZse9zlFTt0Bgh856cBQ7uIAX1Nf/gktn
         Fnpk8EBG9Yxltcg6qp4aJ3zcKbdTuxFvjUmLXRZVDRkhJv/78PaRegroRjdV/VwOz7
         JwjKqIR6R0x/KDnxrJy2JI+sAj0S+6hvYoVueXZdSCt8ls7K/F5Cs85GNZJ94ShPah
         bhqNcV8bxPaDg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id B4CE1C433E4; Thu, 25 Aug 2022 21:30:55 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-scsi@vger.kernel.org
Subject: [Bug 216413] [BISECT INCLUDED] scsi/sd Rework asynchronous resume
 support breaks S2idle and S3 on several systems
Date:   Thu, 25 Aug 2022 21:30:55 +0000
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
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-216413-11613-QLyY8pNksJ@https.bugzilla.kernel.org/>
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

--- Comment #2 from Todd Brandt (todd.e.brandt@intel.com) ---
Created attachment 301662
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D301662&action=3Dedit
otcpl-hp-x360-bsw-dmesg.txt

S3 suspend fail dmesg log for the HP Pavillion x360

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are on the CC list for the bug.=

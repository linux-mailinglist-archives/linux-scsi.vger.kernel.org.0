Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E71F51D60F
	for <lists+linux-scsi@lfdr.de>; Fri,  6 May 2022 12:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391098AbiEFLBv (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 6 May 2022 07:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344901AbiEFLBu (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 6 May 2022 07:01:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B051EEFD
        for <linux-scsi@vger.kernel.org>; Fri,  6 May 2022 03:58:06 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651834683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=V4xDXi9MoTjmGgrudkcFX/5Dz6bfy78Vh4PgmcfOJ+M=;
        b=puBveS0qTvq+K1w92x0iCYbaJx+N2T9VYEzhs0I8g8dxK4+eL+XMdxqw0AFDP10FXXkfIH
        uARmLofK6sngNx+jEQLVn/XF3zIMMEYcffL8BpF2MluRIdf6pQNyGTjcjqCzUsWuoLhGfI
        QKmM4tMfeawInNFwWBhrZJly/awPAEAX+xLf+JOnvTs3stbzsflrC4SNWhI4/wSBXglvKq
        McQjTUw5D01SgPw+4REr+2A73tU1NmmYPD/Z6OpYRWO+27KFFQZlsB9+CdpiArtRbquTmI
        fHxlW3TjNjCqNlOwZsLow7A0XMZezB6qdNiyeGRO0lhD5PuclemtJsI6F/wAcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651834683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=V4xDXi9MoTjmGgrudkcFX/5Dz6bfy78Vh4PgmcfOJ+M=;
        b=ruGP8RtHhuoXjhGfYKG08Bq6KDdAoHm8RqxLxEhHET+8b7byIkhrXDM9pKLV948DCgkld4
        xdrZ1xnV79fuI7DA==
To:     linux-scsi@vger.kernel.org
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        Hannes Reinecke <hare@suse.de>,
        Javed Hasan <jhasan@marvell.com>,
        Saurav Kashyap <skashyap@marvell.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 0/4] scsi: PREEMPT_RT related fixes.
Date:   Fri,  6 May 2022 12:57:54 +0200
Message-Id: <20220506105758.283887-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi,

this is what I have in PREEMPT_RT queue for the SCSI stack.
Two of these patches have been posted earlier by Davidlohr in another
series. I then added the statistics change and then I stumbled upon
another get_cpu() usage in bnx2fc so there are four patches now.
Due lack of hardware, the series has been compile tested only.

Sebastian



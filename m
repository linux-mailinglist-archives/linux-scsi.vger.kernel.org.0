Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68BBF2A177A
	for <lists+linux-scsi@lfdr.de>; Sat, 31 Oct 2020 13:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgJaMtq (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 31 Oct 2020 08:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgJaMtp (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 31 Oct 2020 08:49:45 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C489C0613D5
        for <linux-scsi@vger.kernel.org>; Sat, 31 Oct 2020 05:49:45 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 133so7395569pfx.11
        for <linux-scsi@vger.kernel.org>; Sat, 31 Oct 2020 05:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=CseN3BiBpJYn6k+hUUx2TxuA3gS6VM1QHXLDLxQNUzc=;
        b=es1gfJOvBc4ldo2+dsHiNN3TOOg5A8zD1NRtt+Sjnafqh/NPV5QADIddrK/A2J2vkb
         OCgDncNixAS3PiO/LKzWEgcHG95ApG8+uW4+pRA1ir0Vr8V0tGArdvFG9oerpwk9GQuv
         rG3CnvN43F/UWl7pCm4Ll+rAwTs0icP5r+x8M4JugVfbSKP4stBD59eAhr0ntMXxZDhb
         obSFb1ADG/RVCpbG/AOmigDPr16OUluPyaNoWNxddTUO9rCIxKXLGNA3vNeLAvMfbMtF
         ZHdRSK3jhk4d2eRcpQ0XV73gBxH/ffSC/WlUbfahSF4Wz31ndkfaWyKFE62iEV0BI0gt
         kyyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=CseN3BiBpJYn6k+hUUx2TxuA3gS6VM1QHXLDLxQNUzc=;
        b=DoxUv1sUXGozkj6FzJTmcqi+pCFP3IUC0IZmzq1WnYmYTIicHWdjGh9umuFnZMOqIy
         IqMvvhLdXrzFhk0K/a/XCwhRY2lKgmW2zZhNO8QBOjbcKbS83shlCFHwgWwxYDEFRo+x
         Z9m8dCbxgT8BVHUG96aynoBm3Hl7QUonDtJwz1khZBVqdBHBFOVeO0xl8OwztGNCz9tZ
         wYyuj61vamQ26/AcvzKcCDoSFLxSJVJStCM3PSyHB/zQDEOhSvbr5jc7ylmBdNNmlbul
         h5GnZkysj4+o5mxv1S5diliHYh0ebQ7zBPLtfrZBwtqh4xVD6NSN/EC87QeWWiEJKYsf
         S2mg==
X-Gm-Message-State: AOAM530Khx3hI8ErqV6FoslDcrkNuwOapp3T3mIIDWszujZw2OZrAUYO
        tRaTmiRpAICPCZ8YPkvov+307/JmJ9TBfV9NYPg=
X-Google-Smtp-Source: ABdhPJzeuIyr7x+V/SkwSJr8r+aw2stck9yXBW9HYB5/CVQsw1u4TIb6aG6VtL1nEjLjPGdEMWcYHi2KqH7GUqZtzpQ=
X-Received: by 2002:a62:3383:0:b029:160:bcd:370c with SMTP id
 z125-20020a6233830000b02901600bcd370cmr13764993pfz.56.1604148585204; Sat, 31
 Oct 2020 05:49:45 -0700 (PDT)
MIME-Version: 1.0
Reply-To: paulwagne7@gmail.com
Sender: hanuman.namunah@gmail.com
Received: by 2002:a17:90b:4396:0:0:0:0 with HTTP; Sat, 31 Oct 2020 05:49:44
 -0700 (PDT)
From:   Paul Wagner <pw9076424@gmail.com>
Date:   Sat, 31 Oct 2020 13:49:44 +0100
X-Google-Sender-Auth: eikGlhXFhpht2evlB0UL040_AXI
Message-ID: <CAPHENavutUO0G95_7D=dOZo7D3FPKAPyH4mTSmdRP0dhQ6mz8Q@mail.gmail.com>
Subject: =?UTF-8?B?U2Now7ZuZW4gVGFn?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hallo,

Mein Name ist Paul Wagner, ein Familienanwalt des verstorbenen Herrn
Thomas. Ich habe einen Vorschlag f=C3=BCr Sie bez=C3=BCglich meines verstor=
benen
Mandanten Thomas . Bitte schreiben Sie mir f=C3=BCr weitere Einzelheiten
zur=C3=BCck.

Gr=C3=BC=C3=9Fe
Paul Wagner

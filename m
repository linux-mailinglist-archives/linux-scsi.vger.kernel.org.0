Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B360260347
	for <lists+linux-scsi@lfdr.de>; Mon,  7 Sep 2020 19:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgIGRq6 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 7 Sep 2020 13:46:58 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:49672 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729496AbgIGRqw (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 7 Sep 2020 13:46:52 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id CCCC18EE0F8;
        Mon,  7 Sep 2020 10:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1599500809;
        bh=qwU3L64pNFkotVWGHIcfTG3OOJPchayPoQuEP8fzy4w=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=npf7CRB6V7V38UOiN/v4+tAcGa8Hti0R9cIrifjB0T81dnz9izOtIdSlxPgmfVvqh
         3FD4Xvu5+h+UZrgoOqH0tALaywkDY957ptaOoDcKP79A/3nIbqllktiUN9XeUPwoZR
         PCZSce+zqQC2NWMMcblrmX9tTrWk8RbAS++ZZCzg=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dr2h6KKrhgM1; Mon,  7 Sep 2020 10:46:49 -0700 (PDT)
Received: from [153.66.254.174] (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 714658EE0E9;
        Mon,  7 Sep 2020 10:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1599500809;
        bh=qwU3L64pNFkotVWGHIcfTG3OOJPchayPoQuEP8fzy4w=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=npf7CRB6V7V38UOiN/v4+tAcGa8Hti0R9cIrifjB0T81dnz9izOtIdSlxPgmfVvqh
         3FD4Xvu5+h+UZrgoOqH0tALaywkDY957ptaOoDcKP79A/3nIbqllktiUN9XeUPwoZR
         PCZSce+zqQC2NWMMcblrmX9tTrWk8RbAS++ZZCzg=
Message-ID: <1599500808.4232.19.camel@HansenPartnership.com>
Subject: Re: [PATCH] scsi: take module reference during async scan
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Tomas Henzl <thenzl@redhat.com>, linux-scsi@vger.kernel.org
Date:   Mon, 07 Sep 2020 10:46:48 -0700
In-Reply-To: <20200907154745.20145-1-thenzl@redhat.com>
References: <20200907154745.20145-1-thenzl@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, 2020-09-07 at 17:47 +0200, Tomas Henzl wrote:
> During an async scan the driver shost->hostt structures are used,
> that may cause issues when the driver is removed at that time.
> As protection take the module reference.

Can I just ask what issues?  Today, our module model is that
scsi_device_get() bumps the module refcount and therefore makes the
module ineligible to be removed.  scsi_host_get() doesn't do this
because the way the host model is supposed to be coded, we can call
remove at any time but the module won't get freed until the last put of
the host.  I can see we have a potential problem with
scsi_forget_host() racing with the async scan thread ... is that what
you see? What's supposed to happen is that scsi_device_get() starts
failing as soon as the module begins it's exit routine, so if a scan is
in progress, it can't add any new devices ... in theory this means that
the list is stable for scsi_forget_host(), so knowing how that
assumption is breaking would be useful.

James


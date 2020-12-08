Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B53792D3673
	for <lists+linux-scsi@lfdr.de>; Tue,  8 Dec 2020 23:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730775AbgLHWsD (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 8 Dec 2020 17:48:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52639 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725940AbgLHWsC (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 8 Dec 2020 17:48:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607467596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cMekdasT4/RuifFDN/rH2Fl3X1h1kIxQzyY1Zx8OrOI=;
        b=XvsjqZt9o2aaK5hsqD5KRL6/p6G9z5Cg2Ni0RKYJbXt2gseyZRkSqSew9c05fEbyohIdTM
        bkNP07N/1GB/FBFoA4/0YV5Aw56cINoOT71RuFkL79lgOV7IU1dqQXTKncuR+S/Kwh1+U/
        mcAk3qHW/wTW/E1An9qxWIccnrFNkp0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-scN4ZhBWNbu9QSIXUr_WVw-1; Tue, 08 Dec 2020 17:46:33 -0500
X-MC-Unique: scN4ZhBWNbu9QSIXUr_WVw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB65C800D55;
        Tue,  8 Dec 2020 22:46:32 +0000 (UTC)
Received: from ovpn-112-111.phx2.redhat.com (ovpn-112-111.phx2.redhat.com [10.3.112.111])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 570C910016F6;
        Tue,  8 Dec 2020 22:46:32 +0000 (UTC)
Message-ID: <296fddc04dd70d2a608d3f9faf6bc26915ed518b.camel@redhat.com>
Subject: Re: [PATCH 1/3] block: try one write zeroes request before going
 further
From:   "Ewan D. Milne" <emilne@redhat.com>
To:     Tom Yan <tom.ty89@gmail.com>, linux-block@vger.kernel.org
Cc:     linux-scsi@vger.kernel.org
Date:   Tue, 08 Dec 2020 17:46:31 -0500
In-Reply-To: <20201206055332.3144-1-tom.ty89@gmail.com>
References: <20201206055332.3144-1-tom.ty89@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Sun, 2020-12-06 at 13:53 +0800, Tom Yan wrote:
> At least the SCSI disk driver is "benevolent" when it try to decide
> whether the device actually supports write zeroes, i.e. unless the
> device explicity report otherwise, it assumes it does at first.
> 
> Therefore before we pile up bios that would fail at the end, we try
> the command/request once, as not doing so could trigger quite a
> disaster in at least certain case. For example, the host controller
> can be messed up entirely when one does `blkdiscard -z` a UAS drive.
> 

It's not as simple as that.  There are some SCSI devices that support
WRITE ZEROES, but do not return the MAXIMUM WRITE SAME LENGTH in the
block device limits VPD page.  So, some commands might work, and others
might not.  In particular, a commonly-used hypervisor does this.

The sd driver disables the use of write same if certain errors are
returned (INVALID COMMAND w/ INVALID COMMAND OPCODE or INVALID FIELD IN
CDB), but if you do a blkdiscard -z of an entire drive a whole lot of
bios/requests are already queued by the time you get that.

Higher level code checks to see if write zeroes is supported, and
won't queue the requests once it is turned off, but that doesn't
happen until a command fails.  We also check in command setup, see
my earlier patch which deals with spurious blk_update_request errors
if the disablement of write same gets detected there...  I explicitly
did not try to fix that by "testing" with one bio for the reason
Christoph mentions.

-Ewan



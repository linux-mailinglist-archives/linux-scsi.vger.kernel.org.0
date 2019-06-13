Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 815FB44538
	for <lists+linux-scsi@lfdr.de>; Thu, 13 Jun 2019 18:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392704AbfFMQmz (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 13 Jun 2019 12:42:55 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:41936 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392534AbfFMQmz (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 13 Jun 2019 12:42:55 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 30D738EE147;
        Thu, 13 Jun 2019 09:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1560444174;
        bh=5rFAkz1X1kpOdC2+E0ZK/h2h2P0mzwfVwxvWB0KgCOY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=O/UxWPf0c4lf0EGhwyA5/D8kCk7FBAVgtF9mUo524HGFz+ysv6UIJcjZNviXO6b0O
         HrO+EMQXeW1EuczwRgun62bOJjbXy74xJ9QP7/C9KSBg4/LYE5NV+vYCrWhNkq2WJZ
         yCH0HsHsooUEXnpirJliNGZwGE2loKEz03SKRJ2A=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CfJdZmgLTm_n; Thu, 13 Jun 2019 09:42:54 -0700 (PDT)
Received: from jarvis.lan (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 6D5A98EE0C7;
        Thu, 13 Jun 2019 09:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1560444173;
        bh=5rFAkz1X1kpOdC2+E0ZK/h2h2P0mzwfVwxvWB0KgCOY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=alzPDvrXP5wAuPbot1wVZp3gWPa+Xy/mi0kStVfn4EtTn/XtI5O9KUqo9XaiAWVFh
         PYYul5LCPO8A31h336ZSvea8vH0BUAxqDeiL2x5SZtMXiebHM8hgtQ3FgZqZj1m0f9
         8ZgQTeST8sHwWVLkCo26aK4qt0brJlc8BH9qw2iI=
Message-ID: <1560444171.3329.46.camel@HansenPartnership.com>
Subject: Re: [PATCH V2 00/15] scsi: use sg helper to operate sgl
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Ming Lei <ming.lei@redhat.com>, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>, Jim Gill <jgill@vmware.com>,
        Cathy Avery <cavery@redhat.com>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Brian King <brking@us.ibm.com>,
        James Smart <james.smart@broadcom.com>,
        "Juergen E . Fischer" <fischer@norbit.de>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Finn Thain <fthain@telegraphics.com.au>
Date:   Thu, 13 Jun 2019 09:42:51 -0700
In-Reply-To: <20190613071335.5679-1-ming.lei@redhat.com>
References: <20190613071335.5679-1-ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, 2019-06-13 at 15:13 +0800, Ming Lei wrote:
> Hi,
> 
> Most of drivers use sg helpers to operate sgl, however there is
> still a few drivers which operate sgl directly, this way can't
> work in case of chained sgl.

This isn't a useful explanation of the issue you make it sound like a
bug, which it isn't: it's a change of behaviour we'd like to introduce
in SCSI.  Please reword the explanation more along the lines of

---
Scsi MQ makes a large static allocation for the first scatter gather
list chunk for the driver to use.  This is a performance headache we'd
like to fix by reducing the size of the allocation to a 2 element
array.  Doing this will break the current guarantee that any driver
using SG_ALL doesn't need to use the scatterlist iterators and can get
away with directly dereferencing the array.  Thus we need to update all
drivers to use the scatterlist iterators and remove direct indexing of
the scatterlist array before reducing the initial scatterlist
allocation size in SCSI.
---

Which explains what we're trying to do and why.

In particular changelogs like this

> The current way isn't safe for chained sgl, so use sgl helper to
> operate sgl.

Are just plain wrong:  They were perfectly safe until you altered the
conditions for using non-chained sgls.  Please use the above
explanation in the patches, abbreviated if you like, so all recipients
know why this needs doing and that it isn't an existing bug.

James


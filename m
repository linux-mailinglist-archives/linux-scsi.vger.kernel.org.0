Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7CE212659
	for <lists+linux-scsi@lfdr.de>; Thu,  2 Jul 2020 16:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbgGBOeG (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 2 Jul 2020 10:34:06 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:40800 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726500AbgGBOeF (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 2 Jul 2020 10:34:05 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 28F658EE16A;
        Thu,  2 Jul 2020 07:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1593700445;
        bh=PODkv2ir3fdxbQnvpKD0cAKdKQYwmq7lH/E/QrIh4XU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=DXhMQ9et1JW5KDuRQMJrjRl6hBzmwTJ8q+r/69a0VYSJ/TkonvVC/S4bH4W+XjuAw
         So9tudHSt8NHmF10lhcW6cY5CwqTFSgjaAIeVX4Jx+fY7Lse9CIo5P1IqP5b/7wFk/
         Gjm1+BbPKskK/OnbAQIf59HAgIphIwAkjQXpPXmE=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tFGkgryOjVao; Thu,  2 Jul 2020 07:34:05 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 8AA008EE0E0;
        Thu,  2 Jul 2020 07:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1593700444;
        bh=PODkv2ir3fdxbQnvpKD0cAKdKQYwmq7lH/E/QrIh4XU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=uKPHJoV2NPtG/iLGrgotbxvQ3vI+cX6oV518M3T6Lc/GLwxayVxtptUia2f9d0kkk
         /PxdWkbn+iXUqOCcWDMGzFH0E1eFoj1ZZJ8uxgIC2+JgWR23lXDYROq1/U0TAiQfu+
         IHf97lHxxVS3Gp4LkmjEjyWn6bXNGgjRHZYoW9G8=
Message-ID: <1593700443.9652.2.camel@HansenPartnership.com>
Subject: Re: [PATCH] scsi: allow state transitions BLOCK -> BLOCK
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bart van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org
Date:   Thu, 02 Jul 2020 07:34:03 -0700
In-Reply-To: <20200702142436.98336-1-hare@suse.de>
References: <20200702142436.98336-1-hare@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, 2020-07-02 at 16:24 +0200, Hannes Reinecke wrote:
> scsi_transport_srp.c will call scsi_target_block() repeatedly
> without calling scsi_target_unblock() first.
> So allow the idempotent state transition BLOCK -> BLOCK to avoid
> a warning here.

That really doesn't sound like a good idea.  Block and unblock should
be matched pairs and since you don't have a running->running transition
allowed this implies that srp calls block many times but unblock only
once.  It really sounds like srp needs fixing.

James


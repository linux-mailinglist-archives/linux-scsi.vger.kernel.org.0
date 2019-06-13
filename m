Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01AD743D4E
	for <lists+linux-scsi@lfdr.de>; Thu, 13 Jun 2019 17:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfFMPlF (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 13 Jun 2019 11:41:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:55560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731895AbfFMJwR (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 13 Jun 2019 05:52:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2615B2133D;
        Thu, 13 Jun 2019 09:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560419536;
        bh=NuI8i4adYDh0Jy3cQk1iNP0nNKi6iHhJS0H1Y1Mhwyg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I7FZy4ULhBHZSlYkiKv2SSHoawGcSR6tCeq3lVoNKMuqo+6FE5tLQgwbHu/rYxc3B
         WWx0PU3+5qR2Sm2WvpG8C2aRtI4M2CWttMQIGfPvjGC+DQm1cYmaswMRxrhgxi0Th0
         a6o1c3mqaYmxc59EShQXVtxLdOjS4ASn2lbtjfSw=
Date:   Thu, 13 Jun 2019 11:52:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Michael Schmitz <schmitzmic@gmail.com>,
        devel@driverdev.osuosl.org, Hannes Reinecke <hare@suse.com>,
        Bart Van Assche <bvanassche@acm.org>,
        James Smart <james.smart@broadcom.com>,
        "Ewan D . Milne" <emilne@redhat.com>, Jim Gill <jgill@vmware.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Brian King <brking@us.ibm.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        "Juergen E . Fischer" <fischer@norbit.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2 08/15] staging: unisys: visorhba: use sg helper to
 operate sgl
Message-ID: <20190613095214.GA18796@kroah.com>
References: <20190613071335.5679-1-ming.lei@redhat.com>
 <20190613071335.5679-9-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613071335.5679-9-ming.lei@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, Jun 13, 2019 at 03:13:28PM +0800, Ming Lei wrote:
> The current way isn't safe for chained sgl, so use sg helper to
> operate sgl.

I can not make any sense out of this changelog.

What "isn't safe"?  What is a "sgl"?

Can this be applied "out of order"?

confused,

greg k-h

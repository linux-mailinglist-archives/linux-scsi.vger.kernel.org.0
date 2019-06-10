Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 266433BBE4
	for <lists+linux-scsi@lfdr.de>; Mon, 10 Jun 2019 20:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387456AbfFJSio (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 10 Jun 2019 14:38:44 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:57196 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387398AbfFJSio (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 10 Jun 2019 14:38:44 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id E4A108EE182;
        Mon, 10 Jun 2019 11:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1560191923;
        bh=dkR/Q0vqxf96+TJXzN8TRBoDCD/9pXb95BEkuES1VEw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=XmmlLlqaNenw8kYTjGidr8tp56vBfsUjW+3b6YcozToAcoWL544KXBBPdW8oogTbP
         4IRRPux/vv/RFi6NwteTdwLE/vKDoly9cMCo5a183qjbGAlFBWzNjLvdBr2F1DsluO
         LXAmwiIPNKFd3Y9K2zUBUTInd8hdmNhGOhtplv5A=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id S5QQQAVQtQQQ; Mon, 10 Jun 2019 11:38:43 -0700 (PDT)
Received: from jarvis.lan (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 49A448EE105;
        Mon, 10 Jun 2019 11:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1560191923;
        bh=dkR/Q0vqxf96+TJXzN8TRBoDCD/9pXb95BEkuES1VEw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=XmmlLlqaNenw8kYTjGidr8tp56vBfsUjW+3b6YcozToAcoWL544KXBBPdW8oogTbP
         4IRRPux/vv/RFi6NwteTdwLE/vKDoly9cMCo5a183qjbGAlFBWzNjLvdBr2F1DsluO
         LXAmwiIPNKFd3Y9K2zUBUTInd8hdmNhGOhtplv5A=
Message-ID: <1560191921.3698.9.camel@HansenPartnership.com>
Subject: Re: [PATCH 3/5] scsi: ipr: use sg helper to operate sgl
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Ming Lei <ming.lei@redhat.com>, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>, Jim Gill <jgill@vmware.com>,
        Cathy Avery <cavery@redhat.com>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Brian King <brking@us.ibm.com>,
        James Smart <james.smart@broadcom.com>
Date:   Mon, 10 Jun 2019 11:38:41 -0700
In-Reply-To: <20190610150317.29546-4-ming.lei@redhat.com>
References: <20190610150317.29546-1-ming.lei@redhat.com>
         <20190610150317.29546-4-ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, 2019-06-10 at 23:03 +0800, Ming Lei wrote:
> The current way isn't safe for chained sgl, so use sg helper to
> operate sgl.

ipr doesn't use chaining, so it can likewise assume a contiguous
scatterlist.  Since the hardware seems to have a 64 entry limit, it
looks like it never will use chaining.

James


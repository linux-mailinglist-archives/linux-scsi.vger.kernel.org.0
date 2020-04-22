Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC301B4788
	for <lists+linux-scsi@lfdr.de>; Wed, 22 Apr 2020 16:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgDVOld (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 22 Apr 2020 10:41:33 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:57652 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725810AbgDVOlc (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 22 Apr 2020 10:41:32 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 57E2F8EE19C;
        Wed, 22 Apr 2020 07:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1587566492;
        bh=JpvkGBcMoi/nwM6TimRHNVqLYdLfv1Jl1MKwS+sPS0M=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=lYJklvguqxm4JPPHjcg8zANe4tg8U+xHydcByA9LgS1pci9SEiYiKud7f0IjUUHZv
         Im7qcM4HX9Xr0zjMRZYCl2QRt9f9Oni4LhLlKQpZ2JEqjruwYO0vykh8NEG8ZLmHZL
         WZ5T27IfD/C06D1g6147qARt+EAs1Ki+HOg21JzM=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JndJ_a63X6UU; Wed, 22 Apr 2020 07:41:32 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id B381A8EE0CE;
        Wed, 22 Apr 2020 07:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1587566492;
        bh=JpvkGBcMoi/nwM6TimRHNVqLYdLfv1Jl1MKwS+sPS0M=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=lYJklvguqxm4JPPHjcg8zANe4tg8U+xHydcByA9LgS1pci9SEiYiKud7f0IjUUHZv
         Im7qcM4HX9Xr0zjMRZYCl2QRt9f9Oni4LhLlKQpZ2JEqjruwYO0vykh8NEG8ZLmHZL
         WZ5T27IfD/C06D1g6147qARt+EAs1Ki+HOg21JzM=
Message-ID: <1587566490.3485.7.camel@HansenPartnership.com>
Subject: Re: [PATCH V2] scsi: put hot fields of scsi_host_template into one
 cacheline
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Ming Lei <ming.lei@redhat.com>, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        John Garry <john.garry@huawei.com>
Date:   Wed, 22 Apr 2020 07:41:30 -0700
In-Reply-To: <20200422095425.319674-1-ming.lei@redhat.com>
References: <20200422095425.319674-1-ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, 2020-04-22 at 17:54 +0800, Ming Lei wrote:
> The following three fields of scsi_host_template are referenced in
> scsi IO submission path, so put them together into one cacheline:
> 
> - cmd_size
> - queuecommand
> - commit_rqs

Are there benchmarks to show this actually makes a difference, if so,
how much?

James


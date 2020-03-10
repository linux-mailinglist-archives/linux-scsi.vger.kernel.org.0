Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6EA1806B8
	for <lists+linux-scsi@lfdr.de>; Tue, 10 Mar 2020 19:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbgCJSfP (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 10 Mar 2020 14:35:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44868 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727526AbgCJSfO (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 10 Mar 2020 14:35:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=f2QIKjI8cYNlOJbeMqgxIhxEPRSUmrEl+tsAYjSK8m8=; b=H7Hg3iHhU9Pw60VhTAE9cYI6HR
        2toN/jrJZ6zBbyrU0G7lJrEeLpeekDWBK9hhLqMI5Koq3UHLf0o/gLNWYajwyZEp9mivPiKG5dbHU
        lYv2ueIuG2okv8ihdoPp19X46Uuk0YubE/yk/cUdeH85mHgOHyQR/Z40XEGShkUtc2WQsjM5tNdn1
        u7KUHl8+5GQ455+JRI2KBRzr1CKF9+Ti8uSEuxAYcFqpnDuQXCKNGa4NYktKWVRUN95/brwwxfDQ7
        U7gQA1jmJuWgJAcoJnQ/dK64b99M7ZqjRhMIPA5KZpMYYoAiIG4d8MEvM9enYix/NFph/hu+l1qzX
        0Apbw/eA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jBjia-0007xl-Nv; Tue, 10 Mar 2020 18:35:04 +0000
Date:   Tue, 10 Mar 2020 11:35:04 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     John Garry <john.garry@huawei.com>
Cc:     axboe@kernel.dk, jejb@linux.ibm.com, martin.petersen@oracle.com,
        hare@suse.de, ming.lei@redhat.com, bvanassche@acm.org,
        hch@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        esc.storagedev@microsemi.com, chenxiang66@hisilicon.com,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH RFC v2 22/24] scsi: drop scsi command list
Message-ID: <20200310183504.GB14549@infradead.org>
References: <1583857550-12049-1-git-send-email-john.garry@huawei.com>
 <1583857550-12049-23-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583857550-12049-23-git-send-email-john.garry@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Mar 11, 2020 at 12:25:48AM +0800, John Garry wrote:
> From: Hannes Reinecke <hare@suse.com>
> 
> No users left, kill it.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.com>

Wasn't this part of a series from Hannes that already got merged?

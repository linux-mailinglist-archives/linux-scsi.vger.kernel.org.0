Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8D8DF883
	for <lists+linux-scsi@lfdr.de>; Tue, 22 Oct 2019 01:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730646AbfJUXUJ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 21 Oct 2019 19:20:09 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:52602 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730146AbfJUXUI (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 21 Oct 2019 19:20:08 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id CECBF29E53;
        Mon, 21 Oct 2019 19:20:05 -0400 (EDT)
Date:   Tue, 22 Oct 2019 10:20:03 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Douglas Gilbert <dgilbert@interlog.com>
cc:     Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH RFC 00/24] scsi: Revamp result values
In-Reply-To: <8e07f2ba-cdef-6faa-559d-3beabc173edf@interlog.com>
Message-ID: <alpine.LNX.2.21.1910221017490.14@nippy.intranet>
References: <20191021095322.137969-1-hare@suse.de> <8e07f2ba-cdef-6faa-559d-3beabc173edf@interlog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, 21 Oct 2019, Douglas Gilbert wrote:

> 
> > As usual, comments and reviews are welcome.
> 
> It is hard to make an omelette without breaking some eggs.
> 

Coccinelle can minimize the breakage; particularly the 
straight-forward conversion of (FOO << 1) to SAM_STAT_BAR.

-- 

> Doug Gilbert
> 

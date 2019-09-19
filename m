Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28050B807C
	for <lists+linux-scsi@lfdr.de>; Thu, 19 Sep 2019 19:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392007AbfISRy4 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 19 Sep 2019 13:54:56 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:47250 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S2391157AbfISRy4 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 19 Sep 2019 13:54:56 -0400
Received: (qmail 1965 invoked by uid 2102); 19 Sep 2019 13:54:54 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Sep 2019 13:54:54 -0400
Date:   Thu, 19 Sep 2019 13:54:54 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Andrea Vai <andrea.vai@unipv.it>
cc:     Johannes Thumshirn <jthumshirn@suse.de>,
        Jens Axboe <axboe@kernel.dk>,
        USB list <linux-usb@vger.kernel.org>,
        SCSI development list <linux-scsi@vger.kernel.org>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        Hannes Reinecke <hare@suse.com>,
        Ming Lei <ming.lei@redhat.com>, Omar Sandoval <osandov@fb.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Slow I/O on USB media after commit f664a3cc17b7d0a2bc3b3ab96181e1029b0ec0e6
In-Reply-To: <7db7c96626121e614320a87cc5ec4f48996211c5.camel@unipv.it>
Message-ID: <Pine.LNX.4.44L0.1909191353400.1962-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, 19 Sep 2019, Andrea Vai wrote:

> BTW, another question: Alan refers to the slow media as a "consumer-
> grade USB storage device". What could I do to identify and buy a "good
> media"? Are there any features to look for?

In general, USB flash drives should not be expected to work as well as 
an actual disk drive connected over USB.

Alan Stern


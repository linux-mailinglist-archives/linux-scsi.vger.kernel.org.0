Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6AC018683C
	for <lists+linux-scsi@lfdr.de>; Mon, 16 Mar 2020 10:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730535AbgCPJxM (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 16 Mar 2020 05:53:12 -0400
Received: from verein.lst.de ([213.95.11.211]:53441 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730459AbgCPJxI (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 16 Mar 2020 05:53:08 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B6D0F68CEC; Mon, 16 Mar 2020 10:53:06 +0100 (CET)
Date:   Mon, 16 Mar 2020 10:53:06 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kai Makisara <Kai.Makisara@kolumbus.fi>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>
Subject: Re: [PATCH v3 4/5] scsi/st: Use get_unaligned_be24() and
 sign_extend32()
Message-ID: <20200316095306.GB13730@lst.de>
References: <20200313203102.16613-1-bvanassche@acm.org> <20200313203102.16613-5-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313203102.16613-5-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

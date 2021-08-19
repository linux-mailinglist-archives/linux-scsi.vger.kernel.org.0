Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D975D3F13D5
	for <lists+linux-scsi@lfdr.de>; Thu, 19 Aug 2021 08:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbhHSGxz (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 19 Aug 2021 02:53:55 -0400
Received: from verein.lst.de ([213.95.11.211]:36266 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231945AbhHSGxy (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 19 Aug 2021 02:53:54 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id CF5BB68AFE; Thu, 19 Aug 2021 08:53:14 +0200 (CEST)
Date:   Thu, 19 Aug 2021 08:53:14 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kevin Mitchell <kevmitch@arista.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] lkdtm: replace SCSI_DISPATCH_CMD with
 SCSI_QUEUE_RQ
Message-ID: <20210819065314.GA4329@lst.de>
References: <20210819022940.561875-1-kevmitch@arista.com> <20210819022940.561875-2-kevmitch@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819022940.561875-2-kevmitch@arista.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

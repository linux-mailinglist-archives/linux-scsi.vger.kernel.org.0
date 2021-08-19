Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93FBD3F13D9
	for <lists+linux-scsi@lfdr.de>; Thu, 19 Aug 2021 08:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbhHSGyK (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 19 Aug 2021 02:54:10 -0400
Received: from verein.lst.de ([213.95.11.211]:36277 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232019AbhHSGyI (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 19 Aug 2021 02:54:08 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C59C268AFE; Thu, 19 Aug 2021 08:53:28 +0200 (CEST)
Date:   Thu, 19 Aug 2021 08:53:28 +0200
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
Subject: Re: [PATCH v2 2/2] lkdtm: remove IDE_CORE_CP crashpoint
Message-ID: <20210819065328.GB4329@lst.de>
References: <20210819022940.561875-1-kevmitch@arista.com> <20210819022940.561875-3-kevmitch@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819022940.561875-3-kevmitch@arista.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

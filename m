Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6322B3EA3
	for <lists+linux-scsi@lfdr.de>; Mon, 16 Nov 2020 09:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgKPI2Q (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 16 Nov 2020 03:28:16 -0500
Received: from verein.lst.de ([213.95.11.211]:53510 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbgKPI2Q (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 16 Nov 2020 03:28:16 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0F2F56736F; Mon, 16 Nov 2020 09:28:13 +0100 (CET)
Date:   Mon, 16 Nov 2020 09:28:12 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Tom Rix <trix@redhat.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: sd: remove obsolete variable in sd_remove()
Message-ID: <20201116082812.GA17192@lst.de>
References: <20201116070035.11870-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116070035.11870-1-lukas.bulwahn@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

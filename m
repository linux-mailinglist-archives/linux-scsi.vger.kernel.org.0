Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84E9C13AD0E
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Jan 2020 16:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbgANPFl (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 14 Jan 2020 10:05:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:47484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726450AbgANPFk (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 14 Jan 2020 10:05:40 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF6982467D;
        Tue, 14 Jan 2020 15:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579014340;
        bh=r3wNhVw5AZzZVqBgn28DrRg3pRR9zCUi/o77MuqLd7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X70UJM6fVByW71pCqmtwmGQIsDsb6IvWRmvWxjj7vyLaTu/bzv/KKrXlu5ZBoS6sG
         b2ww6UEsIaVzyBTVz2akPeQmnP9J2dPfP/N1o/FqDpYE4sInU/UQ4o7JmyzamlVD1k
         oE8FNidfR50PgQvbItCK1BV33zz++u+Xrzr4ZyD0=
Date:   Tue, 14 Jan 2020 16:05:37 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     rafael@kernel.org, lduncan@suse.com, cleech@redhat.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        open-iscsi@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH 2/3] drivers: base: Propagate errors through the
 transport component
Message-ID: <20200114150537.GB1975425@kroah.com>
References: <20200106185817.640331-1-krisman@collabora.com>
 <20200106185817.640331-3-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106185817.640331-3-krisman@collabora.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, Jan 06, 2020 at 01:58:16PM -0500, Gabriel Krisman Bertazi wrote:
> The transport registration may fail.  Make sure the errors are
> propagated to the callers.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

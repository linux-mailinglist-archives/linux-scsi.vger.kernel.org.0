Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7B6254475
	for <lists+linux-scsi@lfdr.de>; Thu, 27 Aug 2020 13:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbgH0LmY (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 27 Aug 2020 07:42:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:46818 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728824AbgH0LmR (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 27 Aug 2020 07:42:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 52A58AE17;
        Thu, 27 Aug 2020 11:42:39 +0000 (UTC)
Date:   Thu, 27 Aug 2020 13:42:06 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Martin Wilck <mwilck@suse.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nilesh Javali <njavali@marvell.com>
Subject: Re: [PATCH 1/4] qla2xxx: Reset done and free callback pointer on
 release
Message-ID: <20200827114206.txu5553uridoqk7o@beryllium.lan>
References: <20200827095829.63871-1-dwagner@suse.de>
 <20200827095829.63871-2-dwagner@suse.de>
 <04f76144372753cceab48f59f7f2aaea017f021f.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04f76144372753cceab48f59f7f2aaea017f021f.camel@suse.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

> How about setting them to a dummy function that prints a big fat
> warning?

Good idea. I'll update the patch accordingly. This might even help to
find the real cause.

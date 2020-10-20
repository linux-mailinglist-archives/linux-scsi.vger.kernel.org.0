Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B6D2933BB
	for <lists+linux-scsi@lfdr.de>; Tue, 20 Oct 2020 05:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391333AbgJTDxa (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 19 Oct 2020 23:53:30 -0400
Received: from 68.66.194.29.static.a2webhosting.com ([68.66.194.29]:34938 "EHLO
        server.mobibuyer.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2391331AbgJTDxa (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 19 Oct 2020 23:53:30 -0400
X-Greylist: delayed 2344 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Oct 2020 23:53:29 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kolors.ae;
         s=default; h=Content-Transfer-Encoding:Content-Type:Message-ID:References:
        In-Reply-To:Subject:To:From:Date:MIME-Version:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=13yft7Hb+0Eu/vS4oBxxG8YZC0QBD2nN4/GChWsTrYs=; b=eEEB9p2mCZW0iP/C5PP0H61OgM
        WpBsNP7dGH8ltHy7yPmOaV00hGrmqzAJ/+Hxw44E22BKK1YyghEoXkzlH/C5T+OuM0oYdAPz3MCjX
        wvwyS/769lVyEYBtfbhiBdETOv/8s//N47LQ1QkDrTCJ0zrBHrsb4zqdAOSCS2Fq9ejk+P03h/9eo
        kveQrIZERAzuNHeg+Dj+oleffs+JLCXJLbDbLO9M8pt85AvJktl8vXb8B7IXOqFXb3CVKcpianeLD
        E5t6ij130CDZ8QHQbftLcOU1okr41/YqLC0aRroI3gfPEXG/v0nwxUlp4EoaNxLhdVK74rvx2pNez
        j4BvbT3w==;
Received: from [::1] (port=57810 helo=server.mobibuyer.com)
        by server.mobibuyer.com with esmtpa (Exim 4.93)
        (envelope-from <linbansah@gmail.com>)
        id 1kUi6R-00059l-L8; Mon, 19 Oct 2020 23:14:23 -0400
MIME-Version: 1.0
Date:   Tue, 20 Oct 2020 03:14:23 +0000
From:   Linda Hills <linbansah@gmail.com>
To:     undisclosed-recipients:;
Subject: from Linda
In-Reply-To: <dcd4ba76a62ad0724b005bdd7d77da92@gmail.com>
References: <93bc625b661319e9db38b9bccb7539b0@hotmail.com>
 <cf6fd891a80aa5320f067a451b3ed300@hotmail.com>
 <43be5269e8c2a4aee2fcf21fa7753b40@hotmail.com>
 <ec88a61a241eb79e32822f6e9cdd60e5@hotmail.com>
 <8ea4416a9e1becd584b161a8e7d0e0d5@hotmail.com>
 <a2e485b00406815e82cca8e8c505041a@hotmail.com>
 <13dc050f285182c7daa9d605292d9f11@hotmail.com>
 <7c390f7e6e866f8385fc6770bfe8fa77@hotmail.com>
 <02e3620bb80ecf5b4973b12deccc62a5@hotmail.com>
 <0fcb36f814899f435a2c7be193722cc1@hotmail.com>
 <00a8382ad0364045dff0bc88e8581849@hotmail.com>
 <b6b09ab4458bba33445a9e5e4a945b6f@hotmail.com>
 <c75002d63c286a0768c1e27ac3a62e6e@gmail.com>
 <127d71411da3e06e6d10a6fb81ac3881@gmail.com>
 <7925a65181746830be88306a23d07fd6@gmail.com>
 <7fc4b313d8364127d09a6c1438df8425@gmail.com>
 <557ca960ed6605746efc10b34419043a@gmail.com>
 <0a833579070dc0fea5f3ea9189c639d2@gmail.com>
 <640ea0d56ec25e329e2f200a8034ce12@gmail.com>
 <7bbaaee9501a0a7eb205f4b1377a4039@gmail.com>
 <e0e37aa57062af1f65e2460c4da4da35@gmail.com>
 <dcd4ba76a62ad0724b005bdd7d77da92@gmail.com>
Message-ID: <5dd48e8f390067d3bc3df4c320d1460d@gmail.com>
X-Sender: linbansah@gmail.com
User-Agent: Roundcube Webmail/1.3.15
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.mobibuyer.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - gmail.com
X-Get-Message-Sender-Via: server.mobibuyer.com: authenticated_id: info@kolors.ae
X-Authenticated-Sender: server.mobibuyer.com: info@kolors.ae
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Hello,

how are you today?
This is Linda, I have written to you before but no reply,
please I want you to text me on WhatsApp +1(408)9903267
There is something very important that I want to talk to you about.
Linda.

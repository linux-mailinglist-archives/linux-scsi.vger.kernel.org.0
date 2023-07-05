Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88F1749053
	for <lists+linux-scsi@lfdr.de>; Wed,  5 Jul 2023 23:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbjGEVzK (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 5 Jul 2023 17:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbjGEVzI (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 5 Jul 2023 17:55:08 -0400
Received: from mail.sitirkam.com (mail.aurorateknoglobal.com [103.126.10.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DC91BCC;
        Wed,  5 Jul 2023 14:55:07 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.sitirkam.com (Postfix) with ESMTP id 26A745AC5707;
        Thu,  6 Jul 2023 03:47:19 +0700 (WIB)
Received: from mail.sitirkam.com ([127.0.0.1])
        by localhost (mail.sitirkam.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id izVlrtI57c4T; Thu,  6 Jul 2023 03:47:18 +0700 (WIB)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.sitirkam.com (Postfix) with ESMTP id AB9145AC61C0;
        Thu,  6 Jul 2023 03:47:08 +0700 (WIB)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.sitirkam.com AB9145AC61C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitirkam.com;
        s=B8AB377C-ED3B-11EA-8736-9248CAEF674E; t=1688590028;
        bh=o0S1lLmVeP1x1ARSYHBo01SF2R+WrUvfnSqBgm2xusw=;
        h=MIME-Version:To:From:Date:Message-Id;
        b=sBo6Bm5yPbA4miGv2VsYXYf8HNUuFVhnTjJk2JDG6OBX69vw3y/2vCyxv0FeOY46s
         1IBdSDz6kOJp9TUI1mFOVj5jl9abo3p9we5yRNRIGpGDU6O7l77q06Wpuwrhm+6OPY
         cQpQy1cEok89/v4ZmEdNQ6jlGeeVwSIAXIx3kupPAS7BCLmAF4Mpb7xWZSqDGgXoKr
         EMoAbMNCXa/Azpc/8cOmVwQYMy3p3Z8PWsainAPN4r1uDBstVS5BMwscfo6oNdL5kv
         y9KM3yE4F486ApzZ6Ggwil8flGPoD9SDlMAxJPL0/Rkn9KNWLTF52HaCEgeOVzcLvL
         v001zjdM52S/Q==
X-Virus-Scanned: amavisd-new at mail.sitirkam.com
Received: from mail.sitirkam.com ([127.0.0.1])
        by localhost (mail.sitirkam.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id n9BhRzUFR4dw; Thu,  6 Jul 2023 03:47:08 +0700 (WIB)
Received: from [91.224.92.18] (unknown [91.224.92.18])
        by mail.sitirkam.com (Postfix) with ESMTPSA id 7B42C590C74E;
        Thu,  6 Jul 2023 03:46:58 +0700 (WIB)
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Re
To:     Recipients <admin@sitirkam.com>
From:   "Scott Godfrey" <admin@sitirkam.com>
Date:   Wed, 05 Jul 2023 13:49:21 -0700
Reply-To: scottgodfrey858@gmail.com
Message-Id: <20230705204658.7B42C590C74E@mail.sitirkam.com>
X-Spam-Status: Yes, score=7.1 required=5.0 tests=BAYES_99,BAYES_999,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FORGED_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,LOTS_OF_MONEY,
        MONEY_FREEMAIL_REPTO,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: sitirkam.com]
        *  0.2 BAYES_999 BODY: Bayes spam probability is 99.9 to 100%
        *      [score: 0.9999]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 0.9999]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [scottgodfrey858[at]gmail.com]
        * -0.0 SPF_HELO_PASS SPF: HELO matches SPF record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
        *  1.2 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

YOUR EMAIL ACCOUNT WON A DONATION OF $3,500,000.00. CONTACT FOR MORE INFORM=
ATION ON HOW TO RECEIVE YOUR DONATION. CONGRATULATIONS TO YOU.

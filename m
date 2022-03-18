Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF904DE380
	for <lists+linux-scsi@lfdr.de>; Fri, 18 Mar 2022 22:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241133AbiCRV0m (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 18 Mar 2022 17:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241131AbiCRV0j (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 18 Mar 2022 17:26:39 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F46D12E741
        for <linux-scsi@vger.kernel.org>; Fri, 18 Mar 2022 14:25:19 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id g17so16026079lfh.2
        for <linux-scsi@vger.kernel.org>; Fri, 18 Mar 2022 14:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=T/YT8jITLgW7f0YnEkkxDYteBnHJRvTOMarDgnnU8jo=;
        b=OxIPcfB7OTdpBTp94FpA0xhSma6t7LNtt25vlKMhzmJD+gPJrKKo1/vWBFj6LZK1+1
         6zc/jmgbgv+1L1UJjANTajmcRxhGQfmk/9IY8q8DFjRJRrqQJagqN45g17wEuNxiRVy5
         vsFQnw61rK7KeUUWpfMrAqwR2nuO5lbnJ7BaxP4l22wzENOWJR4QQABtaM2/4Y8YLGLd
         7LVLpgaOpSU8aBuofeV2UzwEvjEGjrlxn2YqNWAJo/DczTvE5Mwg7jJGTDMyx2TEKz24
         mF6DPwSo5rPK07NThDTackjAE8HZOCMmhYkfNL4H3rlfZ3lHPw9ERxzyWJfKhcM97jU+
         3vYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=T/YT8jITLgW7f0YnEkkxDYteBnHJRvTOMarDgnnU8jo=;
        b=6jIPe2T+NhaHj9YvjTTb8ZDTks23sib82lnpw5u3bQw1N/9iFpkxUny9NMXKkp9ltH
         vpdyy1gDozd3SWa3z+EbB5XLkdPb5+Y4yrGfmsmpsCFfPWoNDZChoFN35FwwvrgTYEk1
         od6c5BhW5Wyxg7it/uW1f2OnJ7l6YzEpZR8QBpxdpWktir9305GdbDkDLUk+SBa9IGlP
         AMq0EsHwc+slWJBSl7m6NjnkQBXcvLvguiMU4fmiTLyZlkkO6tRLAQPG5yg3sQrexx5w
         0c9ZAGwULd0ST+w/Yvwdi69W24HYogLsl17XXxG1v7Tf9m5k/h3ZO+rHGBWsaHMNn6HQ
         fVjw==
X-Gm-Message-State: AOAM532GLkMa13HFy8Okc79mjyQgB+BaUH67E/sgVXHJVZOhk54Ayucz
        pqw655tKyTCTMZp96zMI5E8OHsEwRMuWOMdys8Y=
X-Google-Smtp-Source: ABdhPJzpjhjih9SBrVkPxbwZ1LIgKumcDFS/Pm7D/kQf7a+LB8Bnzy+FD7tj51+PviptxwzWjMDHOqNQqYCf8b+EQvg=
X-Received: by 2002:ac2:5a0b:0:b0:448:3039:d179 with SMTP id
 q11-20020ac25a0b000000b004483039d179mr7083845lfn.485.1647638717895; Fri, 18
 Mar 2022 14:25:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6520:402a:b0:199:feb0:3ce7 with HTTP; Fri, 18 Mar 2022
 14:25:17 -0700 (PDT)
Reply-To: clmloans9@gmail.com
From:   MR ANTHONY EDWARD <nillapep@gmail.com>
Date:   Fri, 18 Mar 2022 22:25:17 +0100
Message-ID: <CAHJCGRgfpCX1zdTUhS3HyfkQY8XuHBLwwTKKOXPuPD7GK4NKCA@mail.gmail.com>
Subject: SICHERES KREDITANGEBOT BEI 2%
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUBJ_ALL_CAPS,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:12a listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4991]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [clmloans9[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [nillapep[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  3.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

--=20
Ben=C3=B6tigen Sie ein Gesch=C3=A4ftsdarlehen oder ein Darlehen jeglicher A=
rt?
Wenn ja, kontaktieren Sie uns

*Vollst=C3=A4ndiger Name:
* Ben=C3=B6tigte Menge:
*Leihdauer:
*Handy:
*Land:

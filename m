Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240184D78A5
	for <lists+linux-scsi@lfdr.de>; Sun, 13 Mar 2022 23:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbiCMXAt (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 13 Mar 2022 19:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbiCMXAt (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 13 Mar 2022 19:00:49 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B597475626
        for <linux-scsi@vger.kernel.org>; Sun, 13 Mar 2022 15:59:39 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id s25so24130610lfs.10
        for <linux-scsi@vger.kernel.org>; Sun, 13 Mar 2022 15:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=efxDK1uU7DkE4cVJ9myazVuQ4eaJnIyftNcM+xFzvi0=;
        b=Ut9r9L7vwKFDabSxR3YgNavoyQm5J389zUjgVcDRZ+Oe8Yd2Hqcp19AEwHWL5tdzBF
         rt2KLBuR5lbOh66M88Y65IzTkZIdx6LvF6bOvBQ3ayYU7jNRBHFQ3WatQj26NoknEWWg
         vMkhx6bZUSfHYO3PsZreKHHuHH09WAvO5m+9J9ZhYlbxjbsnxhowg7VshkS4G7nCtQdV
         KBX0V6UbW8fyrvygTermfQltTj2dDWpTdrfgGss/esjnvep6wS40QIJUP7urpnwaQglR
         ZuCQNEMr6y7t7Utib6AT4VzwGNDy0iFQP6qEDAER+ouD8kxtnA4C5M79f9F0Qzzo8ra3
         uErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=efxDK1uU7DkE4cVJ9myazVuQ4eaJnIyftNcM+xFzvi0=;
        b=wJSD4qu1yV6Nh5S+cpI03SnOj+7KGqRFR4zG88yDRPJuBnYmNRoE9ojxVSr08mhGQW
         gGl4mpby+VBzmiKrew+HhJnyfY8Wb8nD9z+Wkd2c/Ih4xt7zhQUVBS/sjBfi/jk9hYDD
         Jv1kdlHElKw7fh094yXuV3SgPiw2HkdbyLVqhkQEmZhsLPTUj+k8ZF9UKl5CANOewbwR
         S838mPraR5wh1wLyLMhLp46lXVbWasMtQazWulZ3wedBnlU/XCvhFncaIyREGU6vEtpf
         +XdsY7TyKPjBq0EcyS/54i+AyiYedxRfVLohtIm9bCaz39fHIcs3171JwZxQ9v8X41Tr
         Uo0w==
X-Gm-Message-State: AOAM5334PUvHYzHB28edEzeMRGBdbtd/BW9fKSt/61oLflRETkgfkyDo
        z3blrLOs0WJdZubOCWAFhgm6qm6o5hxlPJ2QjQ==
X-Google-Smtp-Source: ABdhPJyVOjfPs77tJoc8BkrKyOhjIr7KwAgREIvvrhwAAukVnbnRc686xPXTMaIo+vwAQcxFAyEFJ2pQl041D1ABZpc=
X-Received: by 2002:a05:6512:c11:b0:448:6987:47ca with SMTP id
 z17-20020a0565120c1100b00448698747camr9682872lfu.448.1647212378102; Sun, 13
 Mar 2022 15:59:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6512:68c:0:0:0:0 with HTTP; Sun, 13 Mar 2022 15:59:37
 -0700 (PDT)
Reply-To: fionahill.usa@outlook.com
From:   Fiona Hill <xaviervives77@gmail.com>
Date:   Sun, 13 Mar 2022 15:59:37 -0700
Message-ID: <CAPB_yMRryy7cQKKDt8a6rYHopXFRAJbB-CdDkOfHhsmHC8A+0Q@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

-- 
Diid you see my  message i send to you ? I'm waiting for your urgent respond,
